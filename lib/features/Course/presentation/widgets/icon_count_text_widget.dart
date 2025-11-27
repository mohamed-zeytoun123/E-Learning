import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconCountTextWidget extends StatelessWidget {
  final IconData icon;
  final String count;
  final String text;

  const IconCountTextWidget({
    super.key,
    required this.icon,
    required this.count,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      children: [
        Icon(icon, size: 20.sp, color: AppColors.iconBlue),
        Text(
          count,
          style: AppTextStyles.s16w400.copyWith(color: AppColors.textBlack),
        ),
        Text(
          text,
          style: AppTextStyles.s16w400.copyWith(color: AppColors.textBlack),
        ),
      ],
    );
  }
}
