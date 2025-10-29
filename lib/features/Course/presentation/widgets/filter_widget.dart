import 'dart:developer';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:e_learning/features/course/presentation/widgets/course_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
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
                child: Text(
                  state.coursesError ?? 'Something went wrong',
                  style: TextStyle(fontSize: 16.sp, color: Colors.red),
                ),
              );

            case ResponseStatusEnum.success:
              final courses = state.courses ?? [];
              if (courses.isEmpty) {
                return Center(
                  child: Text(
                    'No courses available',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                );
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
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
                        extra: {
                          "courseSlug": course.slug,
                          "courseCubit": courseCubit,
                        },
                      );
                    },
                    onSave: () => log("Course saved!"),
                  );
                },
                separatorBuilder: (_, __) => SizedBox(height: 15.h),
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
