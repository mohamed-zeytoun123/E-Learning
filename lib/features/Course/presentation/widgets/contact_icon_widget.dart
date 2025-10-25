import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactIconWidget extends StatelessWidget {
  final String iconPath;
  final String nameApp;
  final VoidCallback onTap;
  final Color color;

  const ContactIconWidget({
    super.key,
    required this.iconPath,
    required this.nameApp,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: onTap,
      child: Column(
        spacing: 5.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Center(child: Image(image: AssetImage(iconPath))),
          ),
          Text(
            nameApp,
            style: AppTextStyles.s12w400.copyWith(color: AppColors.textBlack),
          ),
        ],
      ),
    );
  }
}
