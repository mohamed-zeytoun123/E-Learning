import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/app_logo.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/custom_otp.dart';
import 'package:easy_localization/easy_localization.dart';
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
  String? _verificationCode;

  void _handleOtpVerification() {
    if (_verificationCode == null || _verificationCode!.length < 6) {
      _showErrorMessage("Please_enter_the_6-digit_code".tr());
      return;
    }

    context.read<AuthCubit>().otpVerfication(
          widget.phone,
          _verificationCode!,
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

  Widget _buildInstructionText() {
    return Column(
      children: [
        Text(
          "${"We_Have_Sent_A_6-Digit_Code_To_The_Phone_Number".tr()} :\n${widget.phone} ${"Via_SMS".tr()}",
          style: AppTextStyles.s12w400,
          textAlign: TextAlign.center,
        ),
        12.sizedH,
        Text(
          "Please_Enter_The_Code_Down_Below".tr(),
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
            _showSuccessMessage("OTP_verified_successfully".tr());
            // Navigate to reset password page with phone and reset token
            // Use Future.microtask to avoid state emission conflicts
            Future.microtask(() {
              if (context.mounted) {
                // Get the reset token from the AuthCubit state
                final resetToken = context.read<AuthCubit>().state.resetToken;
                context.go(
                  RouteNames.resetPassword,
                  extra: {
                    "phone": widget.phone,
                    "resetToken": resetToken ??
                        _verificationCode, // Use actual reset token or fallback to OTP
                  },
                );
              }
            });
            break;
          case ResponseStatusEnum.failure:
            _showErrorMessage(
              state.otpVerficationError ?? "OTP_verification_failed".tr(),
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

        return CustomButton(
          title: isLoading ? "Loading".tr() : "Next".tr(),
          buttonColor: AppColors.buttonPrimary,
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
                AppLogo(),
                5.sizedH,
                Text(
                  "Lets_make_your_account".tr(),
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                80.sizedH,
                Text(
                  "Otp_Verfication".tr(),
                  style: AppTextStyles.s16w600.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                48.sizedH,
                _buildInstructionText(),
                24.sizedH,
                _buildOtpInput(),
                48.sizedH,
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
