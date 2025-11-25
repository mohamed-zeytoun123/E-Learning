import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
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
  const CourseSlider({super.key});

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

        // Display all courses from API (already limited to 5 by pageSize)
        final courses = state.courses?.courses ?? [];
        final displayCourses = courses;

        return Skeletonizer(
          enabled: state.coursesStatus == ResponseStatusEnum.loading,
          child: SizedBox(
            height: 270.h,
            child: state.courses != null && state.courses!.courses != null
                ? (state.courses!.courses!.isEmpty
                    ? Center(
                        child: Text(
                          'no_courses_available'.tr(),
                          style: TextStyle(fontSize: 14.sp,color: context.colors.textPrimary),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            16.sizedW,
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
