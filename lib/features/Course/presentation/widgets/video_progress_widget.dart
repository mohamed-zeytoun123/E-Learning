import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

class VideoProgressWidget extends StatelessWidget {
  final int completed;
  final int total;
  final bool showDetiels;
  final double hieghtProgress;

  const VideoProgressWidget({
    super.key,
    required this.completed,
    required this.total,
    this.hieghtProgress = 12,
    this.showDetiels = true,
  });

  @override
  Widget build(BuildContext context) {
    // قيمة البار (0 إلى 1)
    final double fraction = total == 0 ? 0 : completed / total;

    // النسبة المئوية للعرض
    final double percentValue = fraction * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999.r),
          child: LinearPercentIndicator(
            lineHeight: hieghtProgress.h,
            percent: fraction.clamp(0, 1), // هون لازم fraction
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
                  '$completed of $total Videos',
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '${percentValue.toStringAsFixed(2)}% Completed',
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
