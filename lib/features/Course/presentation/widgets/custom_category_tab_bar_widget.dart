import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model.dart';
import 'package:e_learning/features/home/presentation/widgets/filtered_bottom_sheet.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCategoryTabBarWidget extends StatelessWidget {
  const CustomCategoryTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (pre, curr) {
        return pre.categoriesStatus != curr.categoriesStatus ||
            pre.coursesStatus != curr.coursesStatus ||
            pre.selectedIndex != curr.selectedIndex;
      },
      builder: (context, state) {
        final selectedIndex = state.selectedIndex;
        final categories = state.categories ?? [];
        final categoriesLoading =
            state.categoriesStatus == ResponseStatusEnum.loading;
        final categoriesError =
            state.categoriesStatus == ResponseStatusEnum.failure;

        // Build tab bar widget
        Widget buildTabBar() {
          if (categoriesLoading) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Row(
                children: List.generate(
                  5,
                  (_) => AppLoading.skeleton(width: 80, height: 35),
                ),
              ),
            );
          }

          if (categoriesError) {
            // Show empty tab bar with retry option
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      final cubit = context.read<CourseCubit>();
                      cubit.getUniversities();
                      cubit.getCategories();
                      cubit.getStudyYears();
                      showFilterBottomSheet(
                        context,
                        courseCubit: cubit,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? AppColors.buttonTapSelected
                            : AppColors.buttonTapNotSelected,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        Icons.tune,
                        size: 20.sp,
                        color: selectedIndex == 0
                            ? AppColors.iconWhite
                            : AppColors.iconBlue,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Row(
              children: List.generate(categories.length + 1, (index) {
                final bool isSelected = index == selectedIndex;
                final tabName = index == 0 ? '' : categories[index - 1].name;

                return GestureDetector(
                  onTap: () {
                    final cubit = context.read<CourseCubit>();
                    cubit.changeSelectedIndex(index);
                    // Fetch courses filtered by category when a category is selected
                    if (index > 0 && categories.isNotEmpty) {
                      final category = categories[index - 1];
                      cubit.getCourses(
                        filters: CourseFiltersModel(categoryId: category.id),
                        reset: true,
                        page: 1,
                      );
                    } else if (index == 0) {
                      // Show all courses when filter tab is selected
                      cubit.getCourses(reset: true, page: 1);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.buttonTapSelected
                          : AppColors.buttonTapNotSelected,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        if (index == 0)
                          GestureDetector(
                            onTap: () {
                              final cubit = context.read<CourseCubit>();
                              cubit.getUniversities();
                              cubit.getCategories();
                              cubit.getStudyYears();
                              showFilterBottomSheet(
                                context,
                                courseCubit: cubit,
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: Icon(
                                Icons.tune,
                                size: 20.sp,
                                color: isSelected
                                    ? AppColors.iconWhite
                                    : AppColors.iconBlue,
                              ),
                            ),
                          ),
                        if (tabName.isNotEmpty)
                          Text(
                            tabName,
                            style: AppTextStyles.s14w400.copyWith(
                              color: isSelected
                                  ? AppColors.textWhite
                                  : AppColors.textPrimary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }

        // Build content widget
        Widget buildContent() {
          if (state.coursesStatus == ResponseStatusEnum.loading) {
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
          }

          if (state.coursesStatus == ResponseStatusEnum.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 50.sp,
                    color: AppColors.iconError,
                  ),
                  12.sizedH,
                  Text(
                    state.coursesError ?? 'Something went wrong',
                    style: AppTextStyles.s16w500.copyWith(
                      color: AppColors.textError,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  20.sizedH,
                  CustomButton(
                    onTap: () {
                      context.read<CourseCubit>().getCourses();
                    },
                    title: "Retry",
                    buttonColor: AppColors.buttonPrimary,
                  ),
                ],
              ),
            );
          }

          final courses = state.courses?.courses ?? [];
          if (courses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: 50.sp,
                    color: AppColors.iconBlue,
                  ),
                  12.sizedH,
                  Text(
                    'No courses available',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            );
          }

          return const FilterWidget();
        }

        return Column(
          children: [
            buildTabBar(),
            8.sizedH,
            Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),
            Expanded(
              child: buildContent(),
            ),
          ],
        );
      },
    );
  }
}
