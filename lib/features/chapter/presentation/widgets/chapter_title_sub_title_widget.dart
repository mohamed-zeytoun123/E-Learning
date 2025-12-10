import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/Course/presentation/widgets/icon_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.formWhite,
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
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.s18w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
            ),
            Row(
              spacing: 7.w,
              children: [
                Text(
                  "$videosText Videos",
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                IconCircleWidget(),
                Text(
                  "$durationText Mins",
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                IconCircleWidget(),
                Text(
                  "$quizText Quiz",
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                //?-------------------------------------------------------------------------
                SizedBox(
                  height: 10.h,

                  child: ElevatedButton.icon(
                    onPressed: () {
                      // جلب ChapterCubit من الـ context
                      final cubit = context.read<ChapterCubit>();

                      // الانتقال لشاشة Downloads Page
                      context.push(
                        RouteNames.downloads,
                        extra: {"chapterCubit": cubit},
                      );
                    },
                    icon: const Icon(Icons.download), // أيقونة مناسبة
                    label: const Text("Cached"), // نص الزر
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                //?-------------------------------------------------------------------------
              ],
            ),
          ],
        ),
      ),
    );
  }
}
