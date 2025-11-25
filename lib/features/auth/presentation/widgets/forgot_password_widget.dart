import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ForgotPasswordWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 0.h),
        minimumSize: Size(0, 0), // removes default min size
        tapTargetSize:
            MaterialTapTargetSize.shrinkWrap, // optional: shrink tap area
        foregroundColor: AppColors.textPrimary,
      ),
      child: Text(
        "forgot_password".tr(),
        style: AppTextStyles.s14w500.copyWith(
          color: AppColors.textPrimary,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.textPrimary,
          decorationThickness: 0.5,
        ),
      ),
    );
  }
}
