import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/Course/data/models/course_model/course_model.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:e_learning/core/router/route_names.dart';

class FilteredCoursesListWidget extends StatelessWidget {
  final List<CourseModel> courses;
  const FilteredCoursesListWidget({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Center(
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
              "No courses available in this category",
              textAlign: TextAlign.center,
              style: AppTextStyles.s18w600.copyWith(color: AppColors.textError),
            ),
            SizedBox(height: 8.h),
            Text(
              "Please select another category or try again later.",
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w400.copyWith(
                color: AppColors.textError.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return CourseInfoCardWidget(
          imageUrl: course.image ?? 'https://picsum.photos/361/180',
          title: course.title,
          subtitle: course.collegeName,
          rating: (course.averageRating ?? 0).toDouble(),
          price: course.price,
          onTap: () {
            final courseCubit = context.read<CourseCubit>();
            context.pushNamed(
              RouteNames.courceInf,
              extra: {"courseSlug": course.slug, "courseCubit": courseCubit},
            );
          },
          onSave: () => log("Course saved!"),
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: 15.h),
    );
  }
}
