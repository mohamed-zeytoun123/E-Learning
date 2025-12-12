import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/style/text_form_field_style.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputPhoneWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final double? width;
  final String hint;
  final String hintKey;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const InputPhoneWidget({
    super.key,
    required this.controller,
    this.width,
    this.icon,
    this.hint = 'Phone Number',
    this.hintKey = 'phone_number',
    this.focusNode,
    this.nextFocusNode,
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
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              focusNode: focusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (_) {
                if (nextFocusNode != null) {
                  FocusScope.of(context).requestFocus(nextFocusNode);
                } else {
                  FocusScope.of(context).requestFocus();
                }
              },
              decoration: TextFormFieldStyle.baseForm(
                AppLocalizations.of(context)?.translate(hintKey) ?? hint,
                context,
                AppTextStyles.s14w400.copyWith(color: context.colors.textGrey),
              ).copyWith(prefixIcon: icon != null ? Icon(icon) : null),
              validator: (value) => Validator.validatePhone(value, context),
            ),
          ),
        ],
      ),
    );
  }
}

