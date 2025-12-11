import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/custom_error_widget.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/courses_result/courses_result_model.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseSlider extends StatelessWidget {
  const CourseSlider({super.key});

  // Card height from CourseInfoCardWidget
  static double get _cardHeight => 297.5.h;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        // Handle error state
        if (state.coursesStatus == ResponseStatusEnum.failure) {
          return SizedBox(
            height: _cardHeight,
            child: const CustomErrorWidget(),
          );
        }

        // Get courses
        final CoursesResultModel? coursesResult = state.courses;
        final List<CourseModel> courses = coursesResult?.courses ?? [];

        return Skeletonizer(
          enabled: state.coursesStatus == ResponseStatusEnum.loading,
          child: SizedBox(
            height: _cardHeight,
            child: courses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 60.sp,
                          color: AppColors.textError.withOpacity(0.7),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'no_courses_available'.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.s18w600.copyWith(
                            color: AppColors.textError,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'select_another_category'.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.s14w400.copyWith(
                            color: AppColors.textError.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: 5),
                    itemCount: courses.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      final courseCubit = context.read<CourseCubit>();
                      return Padding(
                        padding: EdgeInsetsDirectional.only(end: 16.w),
                        child: CourseInfoCardWidget(
                          imageUrl: course.image ?? '',
                          title: course.title,
                          subtitle: course.collegeName,
                          rating: (course.averageRating ?? 0).toDouble(),
                          price: course.price,
                          isFavorite: course.isFavorite,
                          onTap: () {
                            context.push(
                              RouteNames.courceInf,
                              extra: {
                                'courseId': course.id,
                                'courseCubit': courseCubit,
                              },
                            );
                          },
                          onSave: () {
                            courseCubit.toggleFavorite(
                              courseId: '${course.id}',
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
