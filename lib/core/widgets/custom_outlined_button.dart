import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String title;
  final Color? borderColor;
  final VoidCallback? onTap;

  const CustomOutlinedButton({
    super.key,
    required this.title,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 51.h),
        foregroundColor: colors.textPrimary,
        side: BorderSide(
          color: borderColor ?? colors.textBlue,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      child: Text(title,
          style: AppTextStyles.s16w500.copyWith(
            color: colors.textBlue,
          )),
    );
  }
}
