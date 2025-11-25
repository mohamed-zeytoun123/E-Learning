import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchCoursesTabContent extends StatelessWidget {
  final SearchCubit searchCubit;

  const SearchCoursesTabContent({
    super.key,
    required this.searchCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: searchCubit,
      builder: (context, state) {
        // Show loading state
        if (state.status == ResponseStatusEnum.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Show error state
        if (state.status == ResponseStatusEnum.failure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.sp,
                  color: AppColors.textError,
                ),
                16.sizedH,
                Text(
                  state.error ?? 'something_went_wrong'.tr(),
                  style: AppTextStyles.s16w500.copyWith(
                    color: AppColors.textError,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        // Show results
        if (state.status == ResponseStatusEnum.success) {
          if (state.courses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 48.sp,
                    color: AppColors.textGrey,
                  ),
                  16.sizedH,
                  Text(
                    'no_results_found'.tr(),
                    style: AppTextStyles.s16w500.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 20.h,
            ),
            itemCount: state.courses.length,
            itemBuilder: (context, index) {
              final course = state.courses[index];
              return CourseInfoCardWidget(
                imageUrl: course.image ?? 'https://picsum.photos/361/180',
                title: course.title,
                subtitle: course.collegeName,
                rating: course.averageRating?.toDouble() ?? 0.0,
                price: course.price,
                isFavorite: course.isFavorite,
                onTap: () {
                  final courseId = course.id;
                  if (courseId <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid course. Please try again.'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  final courseCubit = context.read<CourseCubit>();
                  context.pushNamed(
                    RouteNames.courceInf,
                    extra: {
                      "courseId": courseId,
                      "courseSlug": course.slug,
                      "courseCubit": courseCubit,
                    },
                  );
                },
                onSave: () {
                  // Toggle favorite functionality can be added here
                },
              );
            },
            separatorBuilder: (_, __) => 15.sizedH,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
