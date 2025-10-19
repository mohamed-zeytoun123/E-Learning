import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final bool showIcon;

  const RatingWidget({super.key, required this.rating, this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showIcon)
            Icon(Icons.star, color: AppColors.ratingStar, size: 16.sp),
          if (showIcon) SizedBox(width: 3.w),
          Text(
            rating.toString(),
            style: AppTextStyles.s14w400.copyWith(color: AppColors.ratingStar),
          ),
        ],
      ),
    );
  }
}
