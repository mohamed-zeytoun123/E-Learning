import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:flutter/material.dart';

class ResetPasswordButtonWidget extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final GlobalKey<FormState> formKey;
  const ResetPasswordButtonWidget({
    super.key,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButtonWidget(
      title: AppLocalizations.of(context)?.translate("Next") ?? "Next",
      titleStyle: AppTextStyles.s16w500.copyWith(
        fontFamily: AppTextStyles.fontGeist,
        color: textColor ?? AppColors.titleBlack,
      ),
      buttonColor: buttonColor ?? AppColors.buttonSecondary,
      borderColor: borderColor ?? AppColors.borderSecondary,
      onTap: () {
        // TODO: Implement forget password functionality
      },
    );
  }
}
