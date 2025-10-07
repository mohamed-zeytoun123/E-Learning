import 'dart:developer';

import 'package:e_learning/core/constant/app_colors.dart';
import 'package:e_learning/core/constant/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final GlobalKey<FormState> formKey;

  const LoginButtonWidget({
    super.key,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: AppLocalizations.of(context)?.translate("Log_in") ?? "Log In",
      titleStyle: AppTextStyles.s16w500.copyWith(
        fontFamily: AppTextStyles.fontGeist,
        color: textColor ?? AppColors.titleBlack,
      ),
      buttonColor: buttonColor ?? AppColors.buttonSecondary,
      borderColor: borderColor ?? AppColors.borderSecondary,
      onTap: () {
        if (formKey.currentState!.validate()) {
          log("Login success ");
        } else {
          log("Form not valid");
        }
      },
    );
  }
}
