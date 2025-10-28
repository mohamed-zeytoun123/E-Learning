import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSettingsItemWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final Color? titleColor;
  final VoidCallback onTap;
  const CustomSettingsItemWidget({
    super.key,
    required this.icon,
    this.iconColor,
    required this.title,
    this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 28.sp,
                  color: iconColor ?? context.colors.iconBlack,
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: AppTextStyles.s14w400.copyWith(
                    color: titleColor ?? context.colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Divider(color:colors.dividerGrey),
        ),
      ],
    );
  }
}
