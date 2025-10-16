import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class VideoProgressWidget extends StatelessWidget {
  final int completedVideos;
  final int totalVideos;

  const VideoProgressWidget({
    super.key,
    required this.completedVideos,
    required this.totalVideos,
  });

  @override
  Widget build(BuildContext context) {
    final int safeTotal = totalVideos <= 0 ? 1 : totalVideos;
    final double percent = (completedVideos / safeTotal).clamp(0.0, 1.0);
    final int percentValue = (percent * 100).round();

    return Column(
      spacing: 15.h,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          "Your Progress",
          style: AppTextStyles.s16w400.copyWith(color: AppColors.textBlack),
        ),

        ClipRRect(
          borderRadius: BorderRadius.circular(999.r),
          child: LinearPercentIndicator(
            lineHeight: 12.h,
            percent: percent,
            backgroundColor: const Color(0xFFF1F1F1),
            progressColor: const Color(0xFF181818),
            barRadius: Radius.circular(999.r),
            animation: true,
            animationDuration: 700,
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$completedVideos Of $totalVideos Videos',
              style: AppTextStyles.s14w400.copyWith(
                color: AppColors.textGrey,
                fontSize: 14.sp,
              ),
            ),
            Text(
              '$percentValue% Completed',
              style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
            ),
          ],
        ),
      ],
    );
  }
}
