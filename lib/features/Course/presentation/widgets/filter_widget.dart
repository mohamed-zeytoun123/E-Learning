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

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        // Handle error state
        if (state.coursesStatus == ResponseStatusEnum.failure) {
          return const CustomErrorWidget();
        }

        return Skeletonizer(
          enabled: state.coursesStatus == ResponseStatusEnum.loading,
          child: state.courses != null
              ? (state.courses!.isEmpty
                  ? Center(
                      child: Text(
                        'no_courses_available'.tr(),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemCount: state.courses!.length,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(16.w),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final course = state.courses![index];
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
        );
      },
    );
  }
}
