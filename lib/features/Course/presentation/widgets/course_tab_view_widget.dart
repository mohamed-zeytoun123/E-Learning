import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/features/Course/presentation/widgets/body_tab_about_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/body_tab_chapter_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/body_tab_reviews_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseTabViewWidget extends StatelessWidget {
  const CourseTabViewWidget({
    super.key,
    required this.isActive,
    required this.courseId,
    required this.courseImage,
    required this.courseTitle,
    required this.price,
    required this.houresDurtion,
  });
  final bool isActive;
  final String? courseImage;
  final String courseTitle;
  final int courseId;
  final double houresDurtion;
  final String price;

  @override
  Widget build(BuildContext context) {
    final colors= context.colors;
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            dividerColor: colors.dividerGrey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: colors.textBlue,
            indicatorWeight: 2.h,
            labelColor: colors.textBlue,
            unselectedLabelColor: colors.textGrey,
            labelStyle: AppTextStyles.s14w600,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow, size: 20.sp),
                    4.sizedW,
                    Text("Chapter"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.format_align_left_outlined, size: 20.sp),
                    4.sizedW,
                    Text("About"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chat_outlined, size: 20.sp),
                    4.sizedW,
                    Text("Reviews"),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                BodyTabChapterWidget(
                  courseId: courseId,
                  isActive: isActive,
                  chapterId: courseId,
                  courseTitle: courseTitle,
                  courseImage: courseImage ?? '',
                  price: price,
                ),
                BodyTabAboutWidget(
                  houresDurtion: houresDurtion,
                  isActive: isActive,
                  courseId: courseId,
                  price: price,
                ),
                BodyTabReviewsWidget(isActive: isActive, courseId: courseId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
