import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/course/presentation/widgets/icon_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChapterTitleSubTitleWidget extends StatelessWidget {
  final String title;
  final String videosText;
  final String durationText;
  final String quizText;

  const ChapterTitleSubTitleWidget({
    super.key,
    required this.title,
    required this.videosText,
    required this.durationText,
    required this.quizText,
  });

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.borderCard)),
        color:colors.background,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          spacing: 15.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.s18w600.copyWith(color: colors.textPrimary),
            ),
            Row(
              spacing: 7.w,
              children: [
                Text(
                  "$videosText Videos",
                  style: AppTextStyles.s14w400.copyWith(
                    color: colors.textGrey,
                  ),
                ),
                IconCircleWidget(),
                Text(
                  "$durationText Mins",
                  style: AppTextStyles.s14w400.copyWith(
                    color: colors.textGrey,
                  ),
                ),
                IconCircleWidget(),
                Text(
                  "$quizText Quiz",
                  style: AppTextStyles.s14w400.copyWith(
                    color: colors.textGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
