import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/custom_otp.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/otp_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.email, required this.purpose});
  final String email;
  final String purpose;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    // Start the OTP timer with improved initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authCubit.startOtpTimer();
    });
  }

  @override
  void dispose() {
    // Stop the timer safely
    _authCubit.stopOtpTimer();
    super.dispose();
  }

  void _handleOtpVerification() {
    final otpCode = _authCubit.state.currentOtpCode;

    if (otpCode == null || otpCode.length < 6) {
      AppMessage.showSnackBar(
        context: context,
        message:
            AppLocalizations.of(
              context,
            )?.translate("Please_enter_the_6-digit_code") ??
            "Please enter the 6-digit code",
        backgroundColor: AppColors.textError,
      );
      return;
    }

    _authCubit.otpVerfication(widget.email, otpCode, widget.purpose);
  }

  Widget _buildOtpInput() {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.otpVerficationState != current.otpVerficationState ||
          previous.resendOtpState != current.resendOtpState,
      listener: (context, state) {
        switch (state.resendOtpState) {
          case ResponseStatusEnum.success:
            AppMessage.showFlushbar(
              context: context,
              message:
                  AppLocalizations.of(
                    context,
                  )?.translate("OTP_sent_successfully") ??
                  "OTP sent successfully",
            );
            break;
          case ResponseStatusEnum.failure:
            AppMessage.showFlushbar(
              context: context,
              message:
                  state.resendOtpError ??
                  (AppLocalizations.of(
                        context,
                      )?.translate("Failed_to_send_OTP") ??
                      "Failed to send OTP"),
            );
            break;
          case ResponseStatusEnum.loading:
          case ResponseStatusEnum.initial:
            break;
        }

        // Handle OTP verification state
        switch (state.otpVerficationState) {
          case ResponseStatusEnum.success:
            AppMessage.showSnackBar(
              context: context,
              message:
                  AppLocalizations.of(
                    context,
                  )?.translate("OTP_verified_successfully") ??
                  "OTP verified successfully",
              backgroundColor: Colors.green,
            );

            // Navigate to reset password page
            Future.microtask(() {
              if (context.mounted) {
                final resetToken = _authCubit.state.resetToken;
                context.go(
                  RouteNames.resetPassword,
                  extra: {
                    "email": widget.email,
                    "resetToken": resetToken ?? state.currentOtpCode,
                  },
                );
              }
            });
            break;
          case ResponseStatusEnum.failure:
            AppMessage.showFlushbar(
              context: context,
              message:
                  state.otpVerficationError ??
                  (AppLocalizations.of(
                        context,
                      )?.translate("OTP_verification_failed") ??
                      "OTP verification failed"),
              backgroundColor: AppColors.textError,
            );
            break;
          case ResponseStatusEnum.loading:
          case ResponseStatusEnum.initial:
            break;
        }
      },
      buildWhen: (previous, current) =>
          previous.otpVerficationState != current.otpVerficationState,
      builder: (context, state) => CustomOtp(
        onCodeChanged: (code) {
          // Check if context is still mounted before calling setOtpCode
          if (context.mounted) {
            _authCubit.setOtpCode(code);
          }
        },
        onSubmit: (code) {
          // Check if context is still mounted before calling setOtpCode
          if (context.mounted) {
            _authCubit.setOtpCode(code);
            // Auto-submit when 6 digits are entered
            if (code.length == 6) {
              _handleOtpVerification();
            }
          }
        },
      ),
    );
  }

  /// Builds the resend OTP widget with countdown timer
  Widget _buildResendOtpWidget() {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.otpTimerSeconds != current.otpTimerSeconds ||
          previous.canResendOtp != current.canResendOtp ||
          previous.resendOtpState != current.resendOtpState,
      builder: (context, state) {
        final isResending = state.resendOtpState == ResponseStatusEnum.loading;

        return OtpResendWidget(
          canResend: state.canResendOtp && !isResending,
          remainingSeconds: state.otpTimerSeconds,
          onResend: () async {
            // Check if context is still mounted before calling cubit methods
            if (context.mounted) {
              await _authCubit.resendOtp(widget.email, widget.purpose);
            }
          },
        );
      },
    );
  }

  /// Builds the submit button with loading state
  Widget _buildSubmitButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.otpVerficationState != current.otpVerficationState,
      builder: (context, state) {
        final isLoading =
            state.otpVerficationState == ResponseStatusEnum.loading;

        return CustomButtonWidget(
          title: isLoading
              ? (AppLocalizations.of(context)?.translate("Loading") ??
                    "Loading...")
              : (AppLocalizations.of(context)?.translate("Next") ?? "Next"),
          titleStyle: AppTextStyles.s16w500.copyWith(
            fontFamily: AppTextStyles.fontGeist,
            color: AppColors.titlePrimary,
          ),
          buttonColor: AppColors.buttonPrimary,
          borderColor: AppColors.borderPrimary,
          onTap: isLoading
              ? null
              : () {
                  // Check if context is still mounted before handling verification
                  if (context.mounted) {
                    _handleOtpVerification();
                  }
                },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            top: 120.h,
            bottom: 50.h,
            right: 15.w,
            left: 15.w,
          ),
          child: Center(
            child: Column(
              children: [
                HeaderAuthPagesWidget(),
                SizedBox(height: 5.h),
                Text(
                  AppLocalizations.of(
                        context,
                      )?.translate("Lets_make_your_account") ??
                      "Let's Make Your Account !",
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: 80.h),
                Text(
                  AppLocalizations.of(context)?.translate("Otp_Verfication") ??
                      "OTP Verification",
                  style: AppTextStyles.s16w600.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: 48.h),
                OtpInstructionWidget(email: widget.email),
                SizedBox(height: 24.h),
                _buildOtpInput(),
                _buildResendOtpWidget(),
                SizedBox(height: 24.h),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
