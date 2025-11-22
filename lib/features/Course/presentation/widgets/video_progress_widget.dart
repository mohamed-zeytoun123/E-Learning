import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class VideoProgressWidget extends StatelessWidget {
  final double completedVideosSecond;
  final int totalVideoSecond;
  final bool showDetiels;
  final double hieghtProgress;

  const VideoProgressWidget({
    super.key,
    required this.completedVideosSecond,
    required this.totalVideoSecond,
    this.hieghtProgress = 12,
    this.showDetiels = true,
  });

  @override
  Widget build(BuildContext context) {
    double percent = double.parse(completedVideosSecond.toString()) / 100;

    final int percentValue = completedVideosSecond.round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999.r),
          child: LinearPercentIndicator(
            lineHeight: hieghtProgress.h,
            percent: percent,
            backgroundColor: AppColors.formSomeWhite,
            progressColor: AppColors.formProgress,
            barRadius: Radius.circular(999.r),
            animation: true,
            animationDuration: 700,
          ),
        ),
        if (showDetiels)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${completedVideosSecond.toStringAsFixed(0)} of $totalVideoSecond Videos',
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '$percentValue% Completed',
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
