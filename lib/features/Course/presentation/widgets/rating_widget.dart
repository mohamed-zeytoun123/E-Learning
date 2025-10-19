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
    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: AppColors.iconOrange, size: 16.sp),
        Text(
          rating.toString(),
          style: AppTextStyles.s14w400.copyWith(color: AppColors.textOrange),
        ),
      ],
    );

    return showIcon
        ? Container(
            height: 25.h,
            width: 43.w,
            decoration: BoxDecoration(
              color: AppColors.backgroundLittelOrange,
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: content,
          )
        : content;
  }
}
