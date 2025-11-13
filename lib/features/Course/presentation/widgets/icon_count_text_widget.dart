import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
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
        Icon(icon, size: 20.sp, color: context.colors.textBlack),
        Text(
          count,
          style: AppTextStyles.s16w400.copyWith(color: context.colors.textPrimary),
        ),
        Text(
          text,
          style: AppTextStyles.s16w400.copyWith(color: context.colors.textPrimary),
        ),
      ],
    );
  }
}
