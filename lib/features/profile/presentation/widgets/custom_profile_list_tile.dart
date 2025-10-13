import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileListTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color titleColor;
  final VoidCallback onTap;
  const CustomProfileListTile({
    super.key,
    required this.icon,
    this.iconColor = AppColors.appBarBlack,
    required this.title,
    this.titleColor = AppColors.textBlack,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ListTile(
            leading: Icon(icon, size: 28.sp, color: iconColor),
            title: Text(
              title,
              style: AppTextStyles.s14w400.copyWith(color: titleColor),
            ),
          ),
        ),
        Divider(color: AppColors.dividerGrey),
      ],
    );
  }
}
