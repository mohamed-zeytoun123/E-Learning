import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/text_form_field_style.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputEmailWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final double? width;
  final FocusNode? focusNode; // Add focusNode parameter
  final FocusNode? nextFocusNode; // Add nextFocusNode parameter

  const InputEmailWidget({
    super.key,
    required this.controller,
    this.width,
    this.icon,
    this.focusNode, // Add focusNode parameter
    this.nextFocusNode, // Add nextFocusNode parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width ?? 361).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70.h,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.emailAddress, // ← تعديل
              textInputAction: TextInputAction.next,
              focusNode: focusNode, // Use focusNode parameter
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (_) {
                // Move focus to the next field if provided, otherwise request focus normally
                if (nextFocusNode != null) {
                  FocusScope.of(context).requestFocus(nextFocusNode);
                } else {
                  FocusScope.of(context).requestFocus();
                }
              },
              decoration: TextFormFieldStyle.baseForm(
                AppLocalizations.of(context)?.translate("Email") ?? "Email",
                context,
                AppTextStyles.s14w400.copyWith(color: context.colors.textGrey),
              ).copyWith(prefixIcon: icon != null ? Icon(icon) : null),
              validator: (value) => Validator.emailValidation(value, context),
            ),
          ),
        ],
      ),
    );
  }
}