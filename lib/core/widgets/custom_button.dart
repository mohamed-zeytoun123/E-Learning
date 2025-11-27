import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.title,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.titleStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 51.h),
        elevation: 0,
        backgroundColor: buttonColor ?? context.colors.textBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide.none,
        ),
      ),
      child: Text(
        title,
        style: titleStyle ??
            AppTextStyles.s16w500.copyWith(
              color: textColor ?? AppColors.textWhite,
            ),
      ),
    );
  }
}
