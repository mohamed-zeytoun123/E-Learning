import 'package:e_learning/features/Course/presentation/widgets/icon_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';

class QuizInfoCardWidget extends StatelessWidget {
  final String title;
  final String quiz;
  final int questionCount;
  final int points;

  const QuizInfoCardWidget({
    super.key,
    required this.title,
    required this.quiz,
    required this.questionCount,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 111.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.formWhite,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.black.withOpacity(0.05), width: 1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.only(left: 20.w, top: 20.h, bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(right: 10.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Text(
              maxLines: 1,
              "$title - $quiz",
              style: AppTextStyles.s18w600.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          Row(
            spacing: 7.w,
            children: [
              Text(
                "$questionCount Questions",
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              IconCircleWidget(),
              Text(
                "$points Points",
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
