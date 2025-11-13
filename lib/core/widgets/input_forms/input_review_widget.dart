import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/style/text_form_field_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputReviewWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String hintKey;
  final double? width;
  final int maxLines;

  const InputReviewWidget({
    super.key,
    required this.controller,
    required this.hint,
    required this.hintKey,
    this.width,
    this.maxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width ?? 361).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: maxLines,
            decoration:
                TextFormFieldStyle.baseForm(
                  hint,
                  context,
                  AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
                ).copyWith(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
