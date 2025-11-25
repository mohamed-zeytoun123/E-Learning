import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
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

  /// دالة لتحويل الثواني إلى دقائق وثواني للعرض
  String formatDuration(double seconds) {
    final int min = seconds ~/ 60;
    final int sec = (seconds % 60).round();
    return '${min}m of${sec}s';
  }

  @override
  Widget build(BuildContext context) {
    // النسبة الدقيقة من 0.0 إلى 1.0
    final double percent = (completedVideosSecond / 100).clamp(0.0, 1.0);

    // النسبة المئوية للعرض
    final int percentValue = (percent * 100).round();

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
                  '$completedVideosSecond Of $totalVideoSecond Videos',
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
