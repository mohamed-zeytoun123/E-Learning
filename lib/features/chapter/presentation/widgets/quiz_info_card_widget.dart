import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/course/presentation/widgets/icon_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class QuizInfoCardWidget extends StatelessWidget {
  final String title;
  final int questionCount;
  final int points;

  const QuizInfoCardWidget({
    super.key,
    required this.title,
    required this.questionCount,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    return Container(
      height: 111.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(24.r),
        
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color:colors.borderCard, width: 1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$title - Quiz",
            style: AppTextStyles.s18w600.copyWith(color: colors.textBlue),
          ),
          SizedBox(height: 8.h),

          Row(
            spacing: 7.w,
            children: [
              Text(
                "$questionCount Questions",
                style: AppTextStyles.s14w400.copyWith(
                  color:colors.textGrey,
                ),
              ),
              IconCircleWidget(),
              Text(
                "$points Points",
                style: AppTextStyles.s14w400.copyWith(
                  color: colors.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
