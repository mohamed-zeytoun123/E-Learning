import 'dart:developer';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:e_learning/features/course/presentation/widgets/course_suspended_bottom_sheet.dart';
import 'package:e_learning/features/course/presentation/widgets/course_suspended_notice_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/course_title_sub_title_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/course/presentation/widgets/course_tab_view_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/rating_widget.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';

class CourceInfoPage extends StatelessWidget {
  const CourceInfoPage({super.key});

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
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start ,
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
                  // **هنا شرط الدفع**
                  BlocSelector<AppManagerCubit, AppManagerState, AppStateEnum>(
                    selector: (state) => state.appState,
                    builder: (context, appState) {
                      if (appState == AppStateEnum.guest) {
                        // ضيف → عرض إشعار الاتصال
                        return CourseSuspendedNoticeWidget(
                          onContactPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: false,
                              builder: (context) =>
                                  const CourseSuspendedBottomSheet(),
                            );
                          },
                        );
                      } else if (appState == AppStateEnum.user) {
                        // هنا نتحقق إذا دفع الكورس أم لا
                        // final hasPaid = context
                        //     .read<AppManagerCubit>()
                        //     .state
                        //     .hasPaidCourse;
                        // if (hasPaid) {
                        //   // عرض البروغريس والـTabs
                        //   return Column(
                        //     children: [
                        //       YourProgressWidget(
                        //         completedVideos: 30,
                        //         totalVideos: 40,
                        //       ),
                        //       SizedBox(height: 16.h),
                        //       CourseTabViewWidget(), // التابات الخاصة بالكورس
                        //     ],
                        //   );
                        // } else {
                        //   // طالب بس ما دفع → عرض إشعار بدون Contact أو رسالة مختلفة
                        return CourseSuspendedNoticeWidget(
                          onContactPressed: () {
                            log("Contact Us clicked");
                          },
                        );
                        // }
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
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
