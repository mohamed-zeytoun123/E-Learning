import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/course/presentation/widgets/rating_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/show_image_teacher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourceReviewCardWidget extends StatelessWidget {
  final String teacherImageUrl;
  final String username;
  final String reviewText;
  final double rating;
  final String timeAgo;

  const CourceReviewCardWidget({
    super.key,
    required this.teacherImageUrl,
    required this.username,
    required this.reviewText,
    required this.rating,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    return SizedBox(
      height: 112.h,
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              spacing: 10.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShowImageTeacherWidget(teacherImageUrl: teacherImageUrl),
                Expanded(
                  child: Column(
                    spacing: 7.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: AppTextStyles.s16w600.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        reviewText,
                        style: AppTextStyles.s14w400.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingWidget(rating: rating),
                          Text(
                            timeAgo,
                            style: AppTextStyles.s12w400.copyWith(
                              color: colors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
