import 'package:e_learning/core/constant/app_colors.dart';
import 'package:e_learning/core/constant/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/text_form_field_style.dart';
import 'package:e_learning/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputPasswordWidget extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final String hint;
  final String hintKey;

  const InputPasswordWidget({
    super.key,
    required this.controller,
    this.width,
    required this.hint,
    required this.hintKey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width ?? 375).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75.h,
            child: TextFormField(
              controller: controller,
              obscureText: true,
              obscuringCharacter: '*',
              textInputAction: TextInputAction.next,
              decoration: TextFormFieldStyle.baseForm(
                AppLocalizations.of(context)?.translate(hintKey) ?? hint,
                context,
                AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
              ),
              validator: (value) => Validator.validatePassword(value, context),
            ),
          ),
        ],
      ),
    );
  }
}
