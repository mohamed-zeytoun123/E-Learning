import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ForgotPasswordWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Text(
            "forgot_password".tr(),
            style: AppTextStyles.s14w500.copyWith(
              color: AppColors.textPrimary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.textPrimary,
              decorationThickness: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
