import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/error/error_state_widget.dart';
import 'package:e_learning/core/widgets/error/no_internet_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:e_learning/features/course/presentation/widgets/course_access_content_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/course_tab_view_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/course_title_sub_title_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/features/course/presentation/widgets/rating_widget.dart';
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
      // context.read<CourseCubit>().getChapters(courseId: "${widget.courseId}");
    });
  }

  @override
  Widget build(BuildContext context) {
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
            appBar: CustomAppBarCourseWidget(
              title: course.title,
              showBack: true,
            ),
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
                      appImage:
                          course.image ??
                          'https://picsum.photos/361/180', //todo remove image dynamic
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 262,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.formWhite,
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
                                    color: AppColors.textBlack,
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
                  child: CourseTabViewWidget(
                    countChapter: 123456,
                    //  course.totalChapters,
                    countVideos: course.totalVideos,
                    houresDurtion: course.totalVideoDurationHours,
                    price: course.price,
                    courseId: course.id,
                    isActive: isActive,
                    courseTitle: course.categoryDetail.name,
                    courseImage: course.image,
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
