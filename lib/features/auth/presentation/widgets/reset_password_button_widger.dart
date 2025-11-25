import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ResetPasswordButtonWidget extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onResetPassword;

  const ResetPasswordButtonWidget({
    super.key,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    required this.formKey,
    this.isLoading = false,
    required this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: isLoading ? "Loading".tr() : "Reset_Password".tr(),
      buttonColor: buttonColor ?? AppColors.buttonSecondary,
      onTap: isLoading ? null : onResetPassword,
    );
  }
}
