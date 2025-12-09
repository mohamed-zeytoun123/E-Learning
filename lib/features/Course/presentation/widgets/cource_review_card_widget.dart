import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
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

  void _showFullReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(username, style: AppTextStyles.s16w600),
        content: SingleChildScrollView(
          child: Text(
            reviewText,
            style: AppTextStyles.s14w400.copyWith(color: AppColors.textBlack),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: AppTextStyles.s16w400.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFullReviewDialog(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundPage,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShowImageTeacherWidget(teacherImageUrl: teacherImageUrl),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: AppTextStyles.s16w600.copyWith(
                          color: AppColors.textBlack,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        reviewText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.s14w400.copyWith(
                          color: AppColors.textBlack,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingWidget(rating: rating),
                          Text(
                            timeAgo,
                            style: AppTextStyles.s12w400.copyWith(
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
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
