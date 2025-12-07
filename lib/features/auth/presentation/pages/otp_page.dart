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
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authCubit.startOtpTimer();
    });
  }

  @override
  void dispose() {
    _authCubit.stopOtpTimer();
    _otpController.dispose();
    super.dispose();
  }

  void _handleOtpVerification(String code) {
    if (code.length < 6) {
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

    _authCubit.otpVerfication(widget.email, code, widget.purpose);
  }

  Widget _buildOtpInput() {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.otpVerficationState != current.otpVerficationState ||
          previous.resendOtpState != current.resendOtpState,
      listener: (context, state) {
        // Handle resend OTP messages
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

        // Handle OTP verification messages
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
          if (context.mounted) {
            _authCubit.setOtpCode(code); // تحديث الـ Cubit عند كل تغيير
          }
        },
        onSubmit: (code) {
          _handleOtpVerification(
            code,
          ); // اعتمد على الكود اللي ارسله الـ CustomOtp مباشرة
        },
      ),
    );
  }

  Widget _buildResendOtpWidget() {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.otpTimerSeconds != current.otpTimerSeconds ||
          previous.canResendOtp != current.canResendOtp ||
          previous.resendOtpState != current.resendOtpState,
      builder: (context, state) {
        final isResending = state.resendOtpState == ResponseStatusEnum.loading;

        // عرض التايمر مباشرة بالثواني بشكل سلس
        final minutes = (state.otpTimerSeconds ~/ 60).toString().padLeft(
          2,
          '0',
        );
        final seconds = (state.otpTimerSeconds % 60).toString().padLeft(2, '0');
        final timerText = "$minutes:$seconds";

        return Column(
          children: [
            OtpResendWidget(
              canResend: state.canResendOtp && !isResending,
              remainingSeconds: state.otpTimerSeconds,
              onResend: () async {
                if (context.mounted) {
                  await _authCubit.resendOtp(widget.email, widget.purpose);
                }
              },
            ),
            SizedBox(height: 8.h),
            Text(
              timerText,
              style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
            ),
          ],
        );
      },
    );
  }

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
                  _handleOtpVerification(_otpController.text);
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
