import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:e_learning/features/course/presentation/widgets/course_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';

class FilteredCoursesListWidget extends StatelessWidget {
  final List<CourseModel> courses;
  const FilteredCoursesListWidget({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Center(
        child: SingleChildScrollView(
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
                style: AppTextStyles.s18w600.copyWith(
                  color: AppColors.textError,
                ),
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
        ),
      );
    }

    return BlocListener<CourseCubit, CourseState>(
      listenWhen: (previous, current) =>
          previous.isFavoriteError != current.isFavoriteError,
      listener: (context, state) {
        final message = state.isFavoriteError;
        if (message != null && message.isNotEmpty) {
          AppMessage.showFlushbar(
            title: "Error",
            context: context,
            message: message,
            backgroundColor: AppColors.messageError,
            iconData: Icons.error,
            isShowProgress: true,
            progressColor: AppColors.iconCircle,
            sizeIcon: 30,
            iconColor: AppColors.iconWhite,
          );
        }
      },
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(right: 1.w, left: 1.w, top: 5.h, bottom: 10.h),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final courseSlug = courses[index].id;

          return BlocSelector<CourseCubit, CourseState, bool>(
            selector: (state) {
              final original = state.courses?.courses?.firstWhere(
                (c) => c.id == courseSlug,
              );
              return original?.isFavorite ?? false;
            },
            builder: (context, isFavorite) {
              final course = courses[index];
              return CourseInfoCardWidget(
                imageUrl: course.image ?? '',
                title: course.title,
                subtitle: course.collegeName,
                rating: (course.averageRating ?? 0).toDouble(),
                price: course.price,
                isFavorite: isFavorite,
                onTap: () {
                  final cubit = context.read<CourseCubit>();
                  context.pushNamed(
                    RouteNames.courceInf,
                    extra: {"courseId": course.id, "courseCubit": cubit},
                  );
                },
                onSave: () {
                  context.read<CourseCubit>().toggleFavorite(
                    courseId: "${course.id}",
                  );
                },
              );
            },
          );
        },
        separatorBuilder: (_, __) => SizedBox(height: 15.h),
      ),
    );
  }
}
