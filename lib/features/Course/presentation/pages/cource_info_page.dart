import 'dart:developer';

import 'package:e_learning/features/course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/course/presentation/widgets/course_tab_view_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/course_title_subtitle_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/rating_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/video_progress_widget.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';

class CourceInfoPage extends StatelessWidget {
  const CourceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCourseWidget(title: "Course’s Title", showBack: true),
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 262.h,
            pinned: true,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              background: CustomCachedImageWidget(
                appImage: 'https://picsum.photos/361/180',
                width: double.infinity,
                fit: BoxFit.cover,
                height: 262,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CourseTitleSubtitle(
                        titleStyle: AppTextStyles.s18w600.copyWith(
                          color: AppColors.textBlack,
                        ),
                        title: 'Flutter Development',
                        subtitle: 'Learn to build apps with Flutter',
                      ),
                      RatingWidget(rating: 4.5),
                    ],
                  ),
                  Divider(
                    color: AppColors.dividerGrey,
                    thickness: 1,
                    height: 16.h,
                  ),
                  Text(
                    "Your Progress",
                    style: AppTextStyles.s16w400.copyWith(
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  VideoProgressWidget(completedVideos: 12, totalVideos: 40),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
          SliverFillRemaining(child: CourseTabViewWidget()),
        ],
      ),
    );
  }
}
