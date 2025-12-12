// import 'package:e_learning/core/colors/app_colors.dart';
// import 'package:e_learning/core/style/app_text_styles.dart';
// import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
// import 'package:e_learning/core/widgets/loading/app_loading.dart';
// import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
// import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
// import 'package:e_learning/features/Course/presentation/widgets/course_access_content_widget.dart';
// import 'package:e_learning/features/Course/presentation/widgets/course_tab_view_widget.dart';
// import 'package:e_learning/features/Course/presentation/widgets/course_title_sub_title_widget.dart';
// import 'package:e_learning/features/Course/presentation/widgets/custom_app_bar_course_widget.dart';
// import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:e_learning/features/Course/presentation/widgets/rating_widget.dart';
// import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';

// class CourceInfoPage extends StatefulWidget {
//   const CourceInfoPage({super.key, required this.courseSlug});
//   final String courseSlug;

//   @override
//   State<CourceInfoPage> createState() => _CourceInfoPageState();
// }

// class _CourceInfoPageState extends State<CourceInfoPage> {
//   late bool isActive;

//   @override
//   void initState() {
//     super.initState();
//     isActive = false;

//     Future.microtask(() {
//       context.read<CourseCubit>().getCourseDetails(slug: widget.courseSlug);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CourseCubit, CourseState>(
//       listenWhen: (previous, current) =>
//           previous.courseDetailsStatus != current.courseDetailsStatus,
//       listener: (context, state) {},
//       buildWhen: (previous, current) =>
//           previous.courseDetailsStatus != current.courseDetailsStatus,
//       builder: (context, state) {
//         if (state.courseDetailsStatus == ResponseStatusEnum.loading) {
//           return Scaffold(body: Center(child: AppLoading.circular()));
//         } else if (state.courseDetailsStatus == ResponseStatusEnum.failure &&
//             state.courseDetailsError == "No Connection , Pleas Try Agen") {
//           return Scaffold(
//             body: Container(
//               color: AppColors.backgroundPage,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.wifi_off,
//                     size: 100.r,
//                     color: AppColors.iconOrange,
//                   ),
//                   SizedBox(height: 30.h),
//                   Text(
//                     "no_internet_connection".tr(),
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.s20w600.copyWith(
//                       color: AppColors.textBlack,
//                     ),
//                   ),
//                   SizedBox(height: 10.h),
//                   Text(
//                     "no_connection_please_try_again".tr(),
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.s16w400.copyWith(
//                       color: AppColors.textGrey,
//                     ),
//                   ),
//                   SizedBox(height: 30.h),
//                   CustomButtonWidget(
//                     title: "retry".tr(),
//                     titleStyle: AppTextStyles.s18w600.copyWith(
//                       color: AppColors.titlePrimary,
//                     ),
//                     buttonColor: AppColors.buttonPrimary,
//                     borderColor: AppColors.borderPrimary,
//                     onTap: () {
//                       context.read<CourseCubit>().getCourseDetails(
//                             slug: widget.courseSlug,
//                           );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         } else if (state.courseDetailsStatus == ResponseStatusEnum.success &&
//             state.courseDetails != null) {
//           final course = state.courseDetails!;
//           isActive = course.status == "PUBLISHED";

//           return Scaffold(
//             appBar: CustomAppBarCourseWidget(
//               title: course.title,
//               showBack: true,
//             ),
//             backgroundColor: AppColors.backgroundPage,
//             body: CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//                   expandedHeight: 262.h,
//                   pinned: true,
//                   backgroundColor: AppColors.backgroundPage,
//                   automaticallyImplyLeading: false,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: CustomCachedImageWidget(
//                       appImage: course.image ?? 'https://picsum.photos/361/180',
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       height: 262,
//                     ),
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(24.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           spreadRadius: 0,
//                           blurRadius: 10,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CourseTitleSubTitleWidget(
//                                 titleStyle: AppTextStyles.s18w600.copyWith(
//                                   color: AppColors.textBlack,
//                                 ),
//                                 title: course.title,
//                                 subtitle: course.description,
//                               ),
//                               RatingWidget(rating: 4.5, showIcon: false),
//                             ],
//                           ),
//                           SizedBox(height: 5.h),
//                           CourseAccessContentWidget(
//                             completedVideos: 30,
//                             totalVideos: 40,
//                             videoCount: 28,
//                             hoursCount: 20,
//                             price: course.price,
//                             isActive: isActive,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SliverFillRemaining(
//                   child: CourseTabViewWidget(isActive: isActive),
//                 ),
//               ],
//             ),
//           );
//         }

//         return const Scaffold(body: SizedBox.shrink());
//       },
//     );
//   }
// }
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/error/error_state_widget.dart';
import 'package:e_learning/core/widgets/error/no_internet_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_access_content_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_tab_view_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_title_sub_title_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/features/Course/presentation/widgets/rating_widget.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';

class CourceInfoPage extends StatefulWidget {
  const CourceInfoPage({super.key, required this.courseId});
  final int courseId;

  @override
  State<CourceInfoPage> createState() => _CourceInfoPageState();
}

class _CourceInfoPageState extends State<CourceInfoPage> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = false;

    Future.microtask(() {
      context.read<CourseCubit>().getCourseDetails(id: "${widget.courseId}");
      // Fetch chapters when loading course details
      context.read<CourseCubit>().getChapters(courseId: "${widget.courseId}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (previous, current) =>
          previous.courseDetailsStatus != current.courseDetailsStatus,
      builder: (context, state) {
        if (state.courseDetailsStatus == ResponseStatusEnum.loading) {
          return Scaffold(body: Center(child: AppLoading.circular()));
        } else if (state.courseDetailsStatus == ResponseStatusEnum.failure &&
            state.courseDetailsError == "No Connection , Pleas Try Agen") {
          return NoInternetWidget(
            onRetry: () {
              context.read<CourseCubit>().getCourseDetails(
                id: "${widget.courseId}",
              );
            },
          );
        }
        if (state.courseDetailsStatus == ResponseStatusEnum.failure) {
          return ErrorStateWidget(
            title: "Error",
            message:
                state.courseDetailsError ??
                "Something went wrong. Please try again.",
            onRetry: () {
              context.read<CourseCubit>().getCourseDetails(
                id: "${widget.courseId}",
              );
            },
          );
        } else if (state.courseDetailsStatus == ResponseStatusEnum.success &&
            state.courseDetails != null) {
          final course = state.courseDetails!;
          isActive = course.isPaid;

          return Scaffold(
            appBar: CustomAppBarWidget(
              title: course.title,
              showBack: true,
            ),
            backgroundColor: colors.background,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 262.h,
                  pinned: true,
                  backgroundColor: AppColors.backgroundPage,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CustomCachedImageWidget(
                      appImage: course.image ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 262,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.borderCard)),
                      color: colors.background,
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
                              Expanded(
                                child: CourseTitleSubTitleWidget(
                                  titleStyle: AppTextStyles.s18w600.copyWith(
                                    color: colors.textPrimary,
                                  ),
                                  title: course.title,
                                  subtitle: course.categoryDetail.name,
                                ),
                              ),
                              RatingWidget(
                                rating: course.averageRating ?? 0.0,
                                showIcon: false,
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          CourseAccessContentWidget(
                            courseId: course.id,
                            completedVideos: course.completedVideos,
                            totalVideos: course.totalVideos,
                            videoCount: course.totalVideos,
                            hoursCount: course.totalVideoDurationHours,
                            price: course.price,
                            isActive: isActive,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        height: constraints.maxHeight,
                        child: CourseTabViewWidget(
                          countChapter: course.chaptersCount,
                          //  course.totalChapters,
                          countVideos: course.totalVideos,
                          houresDurtion: course.totalVideoDurationHours,
                          price: course.price,
                          courseId: course.id,
                          isActive: isActive,
                          courseTitle: course.categoryDetail.name,
                          courseImage: course.image,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return ErrorStateWidget(
          title: "Server Error",
          message:
              "Something went wrong on the server. Please try again later.",
          onRetry: () {
            context.read<CourseCubit>().getCourseDetails(
              id: "${widget.courseId}",
            );
          },
        );
      },
    );
  }
}