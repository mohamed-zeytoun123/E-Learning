import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/core/widgets/app_message.dart';
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

    if ((state.courses?.courses?.isEmpty ?? true) ||
        !(state.courses?.hasNextPage ?? false)) {
      return;
    }

    final nextPage = page1 + 1;

    cubit.getCourses(page: nextPage, reset: false).then((_) {
      if (cubit.state.loadCoursesMoreStatus != ResponseStatusEnum.failure) {
        page1 = nextPage;
      }
    }).catchError((_) {
      // Error handled silently
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
                separatorBuilder: (_, __) => 15.sizedH,
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
                    10.sizedH,
                    Text(
                      state.coursesError ?? 'Something went wrong',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.textRed,
                      ),
                    ),
                    15.sizedH,
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
                            "courseId": course.id,
                            "courseCubit": courseCubit,
                          },
                        );
                      },
                      onSave: () {
                        context.read<CourseCubit>().toggleFavorite(
                              courseId: "${course.id}",
                            );
                      },
                    );
                  }

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
                          8.sizedH,
                          Text(
                            state.coursesMoreError ??
                                "Failed to load more courses",
                            style: TextStyle(
                              color: AppColors.textRed,
                              fontSize: 14.sp,
                            ),
                          ),
                          10.sizedH,
                          CustomButton(
                            onTap: () => _handleFetchdata,
                            title: "Retry",
                            buttonColor: AppColors.buttonPrimary,
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
                separatorBuilder: (_, __) => 15.sizedH,
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
            AppMessage.showError(context, message);
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
