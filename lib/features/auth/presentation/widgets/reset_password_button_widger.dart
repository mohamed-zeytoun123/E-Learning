import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
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
    return CustomButtonWidget(
      title: isLoading ? "loading".tr() : "reset_password".tr(),
      titleStyle: AppTextStyles.s16w500.copyWith(
        fontFamily: AppTextStyles.fontGeist,
        color: textColor ?? AppColors.titleBlack,
      ),
      buttonColor: buttonColor ?? AppColors.buttonSecondary,
      borderColor: borderColor ?? AppColors.borderSecondary,
      onTap: isLoading ? null : onResetPassword,
    );
  }
}
