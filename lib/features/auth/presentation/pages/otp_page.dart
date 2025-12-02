import 'dart:developer';
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
  String? _verificationCode;

  void _handleOtpVerification() {
    if (_verificationCode == null || _verificationCode!.length < 6) {
      AppMessage.showFlushbar(
        context: context,
        title: AppLocalizations.of(context)?.translate("wrrong") ?? "Wrrong",
        mainButtonOnPressed: () {
          context.pop();
        },
        mainButtonText: AppLocalizations.of(context)?.translate("ok") ?? "Ok",
        iconData: Icons.error,
        backgroundColor: AppColors.messageError,
        message:
            AppLocalizations.of(
              context,
            )?.translate("Please_enter_the_6-digit_code") ??
            "Please enter the 6-digit code",
        isShowProgress: true,
      );

      return;
    }

    log('Verification Code: $_verificationCode');
    log('Purpose: ${widget.purpose}');

    context.read<AuthCubit>().otpVerfication(
      widget.email,
      _verificationCode!,
      widget.purpose,
    );
  }

  Widget _buildInstructionText() {
    return Column(
      children: [
        Text(
          "${AppLocalizations.of(context)?.translate("We_Have_Sent_A_6-Digit_Code_To_The_Phone_Number") ?? "We Have Sent A 6-Digit Code To The Phone Number"} :\n${widget.email} ${AppLocalizations.of(context)?.translate("Via_SMS") ?? "Via SMS"}",
          style: AppTextStyles.s12w400,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          AppLocalizations.of(
                context,
              )?.translate("Please_Enter_The_Code_Down_Below") ??
              "Please enter the code below to verify",
          style: AppTextStyles.s12w400,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOtpInput() {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.otpVerficationState != current.otpVerficationState,
      listener: (context, state) {
        switch (state.otpVerficationState) {
          case ResponseStatusEnum.success:
            AppMessage.showFlushbar(
              context: context,
              iconData: Icons.check,
              backgroundColor: AppColors.messageSuccess,
              message:
                  AppLocalizations.of(
                    context,
                  )?.translate("OTP_verified_successfully") ??
                  "OTP verified successfully",
            );
            // Navigate to reset password page with phone and reset token
            // Use Future.microtask to avoid state emission conflicts
            Future.microtask(() {
              if (context.mounted) {
                // Get the reset token from the AuthCubit state
                final resetToken = context.read<AuthCubit>().state.resetToken;
                context.go(
                  RouteNames.resetPassword,
                  extra: {
                    "email": widget.email,
                    "resetToken":
                        resetToken ??
                        _verificationCode, // Use actual reset token or fallback to OTP
                  },
                );
              }
            });
            break;
          case ResponseStatusEnum.failure:
            AppMessage.showFlushbar(
              context: context,
              title:
                  AppLocalizations.of(context)?.translate("wrrong") ?? "Wrrong",
              mainButtonOnPressed: () {
                context.pop();
              },
              mainButtonText:
                  AppLocalizations.of(context)?.translate("ok") ?? "Ok",
              iconData: Icons.error,
              backgroundColor: AppColors.messageError,
              message:
                  AppLocalizations.of(
                    context,
                  )?.translate("OTP_verification_failed") ??
                  "OTP verification failed",
              isShowProgress: true,
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
        onSubmit: (code) {
          _verificationCode = code;
          log("OTP Code Entered: $_verificationCode");

          // Auto-submit when 6 digits are entered
          if (code.length == 6) {
            _handleOtpVerification();
          }
        },
      ),
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
                _buildInstructionText(),
                SizedBox(height: 24.h),
                _buildOtpInput(),
                SizedBox(height: 48.h),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
