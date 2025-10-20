import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/chapter_title_sub_title_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/chapters_tab_view_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChaptersPage extends StatelessWidget {
  const ChaptersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      appBar: CustomAppBarCourseWidget(title: "Course’s Title", showBack: true),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 262.h,
            pinned: true,
            backgroundColor: AppColors.backgroundPage,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChapterTitleSubTitleWidget(
                  title: '01 Chapter - Chapter’s Title',
                  videosText: '2',
                  durationText: '122',
                  quizText: '3',
                ),
              ],
            ),
          ),
          SliverFillRemaining(child: ChaptersTabViewWidget()),
        ],
      ),
    );
  }
}
