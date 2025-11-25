import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
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
                12.sizedW,
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
          child: Divider(color: context.colors.dividerGrey, thickness: 1),
        ),
      ],
    );
  }
}
