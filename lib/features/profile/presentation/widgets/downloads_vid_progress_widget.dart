import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DownloadsVidProgressWidget extends StatelessWidget {
  final int completedTime;
  final int totalVidTime;
  const DownloadsVidProgressWidget({
    super.key,
    required this.completedTime,
    required this.totalVidTime,
  });

  @override
  Widget build(BuildContext context) {
    final int safeTotal = totalVidTime <= 0 ? 1 : totalVidTime;
    final double percent = (completedTime / safeTotal).clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(999.r),
      child: LinearPercentIndicator(
        lineHeight: 3.h,
        percent: percent,
        backgroundColor: const Color(0xFFF1F1F1),
        progressColor: Theme.of(context).colorScheme.primary,
        barRadius: Radius.circular(999.r),
        animation: true,
        animationDuration: 700,
      ),
    );
  }
}
