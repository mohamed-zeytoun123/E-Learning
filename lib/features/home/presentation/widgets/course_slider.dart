import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/custom_error_widget.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/home/presentation/widgets/course_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseSlider extends StatelessWidget {
  const CourseSlider({super.key, this.maxItems});

  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        // Handle error state
        if (state.coursesStatus == ResponseStatusEnum.failure) {
          return SizedBox(
            height: 270.h,
            child: const CustomErrorWidget(),
          );
        }

        // Calculate display courses with maxItems limit
        final courses = state.courses?.courses ?? [];
        final displayCourses = maxItems != null && courses.length > maxItems!
            ? courses.take(maxItems!).toList()
            : courses;

        return Skeletonizer(
          enabled: state.coursesStatus == ResponseStatusEnum.loading,
          child: SizedBox(
            height: 270.h,
            child: state.courses != null && state.courses!.courses != null
                ? (state.courses!.courses!.isEmpty
                    ? Center(
                        child: Text(
                          'no_courses_available'.tr(),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16.w),
                        itemCount: displayCourses.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final course = displayCourses[index];
                          return FittedBox(
                            child: CourseCard(
                              price: course.price,
                              title: course.title,
                              collegeName: course.collegeName,
                              imageUrl: course.image,
                              rating: course.averageRating,
                              courseSlug: course.slug,
                            ),
                          );
                        },
                      ))
                : const CustomErrorWidget(),
          ),
        );
      },
    );
  }
}
