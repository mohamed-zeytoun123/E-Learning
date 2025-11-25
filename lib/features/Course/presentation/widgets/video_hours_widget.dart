import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart' hide Colors, TextStyle;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoHoursWidget extends StatelessWidget {
  final int videoCount;
  final double hoursCount;

  const VideoHoursWidget({
    super.key,
    required this.videoCount,
    required this.hoursCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.formSecondary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                Icons.videocam_outlined,
                color: AppColors.iconBlue,
                size: 20.sp,
              ),
              8.sizedW,
              Text(
                '$videoCount',
                style: AppTextStyles.s14w500.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              4.sizedW,
              Text(
                'Videos',
                style: AppTextStyles.s14w500.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          Text(
            '|',
            style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
          ),

          Row(
            children: [
              Icon(Icons.access_time, color: AppColors.iconBlue, size: 20.sp),
              8.sizedW,
              Text(
                '$hoursCount',
                style: AppTextStyles.s14w500.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              4.sizedW,
              Text(
                'Hours',
                style: AppTextStyles.s14w500.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
