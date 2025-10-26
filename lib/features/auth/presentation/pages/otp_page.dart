import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
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
  const OtpPage({super.key, required this.phone, required this.purpose});
  final String phone;
  final String purpose;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  void initState() {
    super.initState();
    // Start the OTP timer
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().startOtpTimer();
    });
  }

  @override
  void dispose() {
    // Stop the timer
    context.read<AuthCubit>().stopOtpTimer();
    super.dispose();
  }

  void _handleOtpVerification() {
    final otpCode = context.read<AuthCubit>().state.currentOtpCode;

    if (otpCode == null || otpCode.length < 6) {
      _showErrorMessage(
        AppLocalizations.of(
              context,
            )?.translate("Please_enter_the_6-digit_code") ??
            "Please enter the 6-digit code",
      );
      return;
    }

    context.read<AuthCubit>().otpVerfication(
      widget.phone,
      otpCode,
      widget.purpose,
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildOtpInput() {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.otpVerficationState != current.otpVerficationState ||
          previous.forgotPasswordState != current.forgotPasswordState ||
          previous.signUpState != current.signUpState,
      listener: (context, state) {
        // Handle OTP verification state
        switch (state.otpVerficationState) {
          case ResponseStatusEnum.success:
            _showSuccessMessage(
              AppLocalizations.of(
                    context,
                  )?.translate("OTP_verified_successfully") ??
                  "OTP verified successfully",
            );

            // Navigate to reset password page
            Future.microtask(() {
              if (context.mounted) {
                final resetToken = context.read<AuthCubit>().state.resetToken;
                context.go(
                  RouteNames.resetPassword,
                  extra: {
                    "phone": widget.phone,
                    "resetToken": resetToken ?? state.currentOtpCode,
                  },
                );
              }
            });
            break;
          case ResponseStatusEnum.failure:
            _showErrorMessage(
              state.otpVerficationError ??
                  (AppLocalizations.of(
                        context,
                      )?.translate("OTP_verification_failed") ??
                      "OTP verification failed"),
            );
            break;
          case ResponseStatusEnum.loading:
          case ResponseStatusEnum.initial:
            break;
        }

        // Handle forgot password state (for resend OTP in password reset)
        if (widget.purpose == 'reset') {
          switch (state.forgotPasswordState) {
            case ResponseStatusEnum.success:
              _showSuccessMessage(
                AppLocalizations.of(
                      context,
                    )?.translate("OTP_resent_successfully") ??
                    "OTP has been resent successfully",
              );
              break;
            case ResponseStatusEnum.failure:
              _showErrorMessage(
                state.forgotPasswordError ??
                    (AppLocalizations.of(
                          context,
                        )?.translate("Failed_to_resend_OTP") ??
                        "Failed to resend OTP"),
              );
              break;
            case ResponseStatusEnum.loading:
            case ResponseStatusEnum.initial:
              break;
          }
        }

        // Handle signup state (for resend OTP in registration)
        if (widget.purpose == 'register') {
          switch (state.signUpState) {
            case ResponseStatusEnum.success:
              _showSuccessMessage(
                AppLocalizations.of(
                      context,
                    )?.translate("OTP_resent_successfully") ??
                    "OTP has been resent successfully",
              );
              break;
            case ResponseStatusEnum.failure:
              _showErrorMessage(
                state.signUpError ??
                    (AppLocalizations.of(
                          context,
                        )?.translate("Failed_to_resend_OTP") ??
                        "Failed to resend OTP"),
              );
              break;
            case ResponseStatusEnum.loading:
            case ResponseStatusEnum.initial:
              break;
          }
        }
      },
      buildWhen: (previous, current) =>
          previous.otpVerficationState != current.otpVerficationState,
      builder: (context, state) => CustomOtp(
        onSubmit: (code) {
          context.read<AuthCubit>().setOtpCode(code);
          // Auto-submit when 6 digits are entered
          if (code.length == 6) {
            _handleOtpVerification();
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
          previous.canResendOtp != current.canResendOtp,
      builder: (context, state) {
        return OtpResendWidget(
          canResend: state.canResendOtp,
          remainingSeconds: state.otpTimerSeconds,
          onResend: () {
            context.read<AuthCubit>().resendOtp(widget.phone, widget.purpose);
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
          onTap: isLoading ? null : _handleOtpVerification,
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
                OtpInstructionWidget(phone: widget.phone),
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
