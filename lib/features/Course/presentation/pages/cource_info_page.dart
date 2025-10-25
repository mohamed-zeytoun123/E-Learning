import 'package:e_learning/features/course/presentation/widgets/course_access_content_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/course_title_sub_title_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/course/presentation/widgets/course_tab_view_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/rating_widget.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';

class CourceInfoPage extends StatefulWidget {
  const CourceInfoPage({super.key});

  @override
  State<CourceInfoPage> createState() => _CourceInfoPageState();
}

class _CourceInfoPageState extends State<CourceInfoPage> {
  late bool isActive;

  @override
  void initState() {
    isActive = true;
    //todo || Assign Active to Fanction From Apis (Cource Detiels)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarCourseWidget(title: "Course’s Title", showBack: true),
      backgroundColor: AppColors.backgroundPage,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 262.h,
            pinned: true,
            backgroundColor: AppColors.backgroundPage,
            automaticallyImplyLeading: false,
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CourseTitleSubTitleWidget(
                          titleStyle: AppTextStyles.s18w600.copyWith(
                            color: AppColors.textBlack,
                          ),
                          title: 'Flutter Development',
                          subtitle: 'Learn to build apps with Flutter',
                        ),
                        RatingWidget(rating: 4.5, showIcon: false),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    CourseAccessContentWidget(
                      completedVideos: 30,
                      totalVideos: 40,
                      videoCount: 28,
                      hoursCount: 20,
                      price: "1800000",
                      isActive: isActive,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverFillRemaining(child: CourseTabViewWidget(isActive: isActive)),
        ],
      ),
    );
  }
}
