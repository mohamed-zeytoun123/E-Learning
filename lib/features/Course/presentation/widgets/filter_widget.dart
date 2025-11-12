import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final ScrollController _scrollController = ScrollController();
  int page1 = 1;

  void _handleFetchdata(BuildContext context) {
    final cubit = context.read<CourseCubit>();
    final state = cubit.state;

    if (state.loadCoursesMoreStatus == ResponseStatusEnum.loading) return;

    // إذا القائمة فارغة أو لا يوجد صفحة تالية لا تحمل المزيد
    if ((state.courses?.courses?.isEmpty ?? true) ||
        !(state.courses?.hasNextPage ?? false)) {
      return;
    }

    final nextPage = page1 + 1;
    log("Fetching more data, page: $nextPage");

    cubit
        .getCourses(page: nextPage, reset: false)
        .then((_) {
          if (cubit.state.loadCoursesMoreStatus != ResponseStatusEnum.failure) {
            page1 = nextPage;
          }
        })
        .catchError((_) {
          log("Fetch failed, keep current page: $page1");
        });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels > position.maxScrollExtent * 0.85) {
        _handleFetchdata(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: BlocConsumer<CourseCubit, CourseState>(
        buildWhen: (previous, current) => previous.courses != current.courses,
        builder: (context, state) {
          final courses = state.courses?.courses ?? [];

          switch (state.coursesStatus) {
            case ResponseStatusEnum.loading:
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) => const CourseInfoCardWidget(
                  title: '',
                  subtitle: '',
                  rating: 0,
                  price: '',
                  isLoading: true,
                ),
                separatorBuilder: (_, __) => SizedBox(height: 15.h),
              );

            case ResponseStatusEnum.failure:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppColors.textRed,
                      size: 40.sp,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      state.coursesError ?? 'Something went wrong',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textRed,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<CourseCubit>().getCourses(page: 1);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case ResponseStatusEnum.success:
              if (courses.isEmpty) {
                return Center(
                  child: Text(
                    'No courses available',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                );
              }

              return ListView.separated(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 60.h),
                itemCount: courses.length + 1,
                itemBuilder: (context, index) {
                  if (index < courses.length) {
                    final course = courses[index];
                    return CourseInfoCardWidget(
                      imageUrl: course.image ?? 'https://picsum.photos/361/180',
                      title: course.title,
                      isFavorite: course.isFavorite,
                      subtitle: course.collegeName,
                      rating: (course.averageRating ?? 0).toDouble(),
                      price: course.price,
                      onTap: () {
                        final courseCubit = context.read<CourseCubit>();
                        context.pushNamed(
                          RouteNames.courceInf,
                          extra: {
                            "courseSlug": course.slug,
                            "courseCubit": courseCubit,
                          },
                        );
                      },
                      onSave: () {
                        context.read<CourseCubit>().toggleFavorite(
                          courseSlug: course.slug,
                        );
                        log("Course saved!");
                      },
                    );
                  }

                  // العنصر الأخير: لودينغ أو خطأ عند تحميل المزيد
                  if (state.loadCoursesMoreStatus ==
                      ResponseStatusEnum.loading) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.h),
                      child: Center(child: AppLoading.circular()),
                    );
                  } else if (state.loadCoursesMoreStatus ==
                      ResponseStatusEnum.failure) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.h),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error,
                            color: AppColors.iconError,
                            size: 40.sp,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.coursesMoreError ??
                                "Failed to load more courses",
                            style: TextStyle(
                              color: AppColors.textRed,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CustomButtonWidget(
                            onTap: () => _handleFetchdata,
                            title: "Retry",
                            titleStyle: AppTextStyles.s14w500.copyWith(
                              color: AppColors.titlePrimary,
                            ),
                            buttonColor: AppColors.buttonPrimary,
                            borderColor: AppColors.borderPrimary,
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
                separatorBuilder: (_, __) => SizedBox(height: 15.h),
              );

            default:
              return const SizedBox.shrink();
          }
        },
        listenWhen: (previous, current) =>
            previous.isFavoriteError != current.isFavoriteError,
        listener: (BuildContext context, CourseState state) {
          final message = state.isFavoriteError;
          if (message != null && message.isNotEmpty) {
            AppMessage.showFlushbar(
              title: "Error",
              isShowProgress: true,
              progressColor: AppColors.iconCircle,
              context: context,
              message: message,
              backgroundColor: AppColors.messageError,
              iconData: Icons.error,
              sizeIcon: 30,
              iconColor: AppColors.iconWhite,
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
