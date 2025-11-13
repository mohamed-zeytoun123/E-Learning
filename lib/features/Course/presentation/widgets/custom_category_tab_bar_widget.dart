import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Course/presentation/widgets/filters_bottom_sheet_widget.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/filter_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/filtered_courses_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCategoryTabBarWidget extends StatelessWidget {
  const CustomCategoryTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (pre, curr) {
        return pre.collegesStatus != curr.collegesStatus ||
            pre.coursesStatus != curr.coursesStatus ||
            pre.selectedIndex != curr.selectedIndex;
      },
      builder: (context, state) {
        final selectedIndex = state.selectedIndex;

        if (state.collegesStatus == ResponseStatusEnum.loading) {
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                child: Row(
                  children: List.generate(
                    5,
                    (_) => AppLoading.skeleton(width: 80, height: 35),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Divider(color:colors.dividerGrey, thickness: 1, height: 0.h),
              Expanded(
                child: ListView.separated(
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
                ),
              ),
            ],
          );
        }

        if (state.collegesStatus == ResponseStatusEnum.failure) {
          return Center(
            child: Column(
              spacing: 20.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.collegesError ?? 'Something went wrong',
                  style: AppTextStyles.s16w500.copyWith(
                    color: AppColors.textError,
                  ),
                ),
                CustomButtonWidget(
                  onTap: () {
                    context.read<CourseCubit>().getColleges();
                    context.read<CourseCubit>().getCourses();
                  },
                  title: "Retry",
                  titleStyle: AppTextStyles.s16w500.copyWith(
                    color: AppColors.titlePrimary,
                  ),
                  buttonColor: AppColors.buttonPrimary,
                  borderColor: AppColors.borderPrimary,
                ),
              ],
            ),
          );
        }

        final college = state.colleges ?? [];
        final courses = state.courses?.courses ?? [];
        if (courses.isNotEmpty) {
          return Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                child: Row(
                  children: List.generate(college.length + 1, (index) {
                    final bool isSelected = index == selectedIndex;
                    final tabName = index == 0 ? '' : college[index - 1].name;

                    return GestureDetector(
                      onTap: () {
                        context.read<CourseCubit>().changeSelectedIndex(index);
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
                              ? colors.textBlue
                              : colors.buttonTapNotSelected,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            if (index == 0)
                              GestureDetector(
                                onTap: () {
                                  // الضغط العادي: يختار الـ tab الخاص بالفلترة
                                  context
                                      .read<CourseCubit>()
                                      .changeSelectedIndex(0);
                                },
                                onLongPress: () {
                                  // الضغط المطول: يفتح البوتوم شيت
                                  final cubit = context.read<CourseCubit>();
                                  cubit.getCategories();
                                  cubit.getStudyYears();
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (_) => BlocProvider.value(
                                      value: cubit,
                                      child: const FiltersBottomSheetWidget(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Icon(
                                    Icons.tune,
                                    size: 20.sp,
                                    color: isSelected
                                        ? AppColors.iconWhite
                                        : colors.textBlue,
                                  ),
                                ),
                              ),

                            if (tabName.isNotEmpty)
                              Text(
                                tabName,
                                style: AppTextStyles.s14w400.copyWith(
                                  color: isSelected
                                      ? AppColors.textWhite
                                      : colors.textBlue,
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
              ),
              SizedBox(height: 8.h),
              Divider(color: colors.dividerGrey, thickness: 1, height: 0.h),
              Expanded(
                child: selectedIndex == 0
                    ? const FilterWidget()
                    : FilteredCoursesListWidget(
                        courses: (selectedIndex == 0)
                            ? state.courses?.courses ?? []
                            : (state.courses?.courses ?? [])
                                  .where(
                                    (course) =>
                                        course.college ==
                                        (state
                                                .colleges?[selectedIndex - 1]
                                                .id ??
                                            0),
                                  )
                                  .map(
                                    (course) =>
                                        state.courses?.courses?.firstWhere(
                                          (c) => c.slug == course.slug,
                                          orElse: () => course,
                                        ) ??
                                        course,
                                  )
                                  .toList(),
                      ),
              ),
            ],
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_book_outlined,
                  size: 50.sp,
                  color: AppColors.iconBlue,
                ),
                SizedBox(height: 12.h),
                Text(
                  'No courses available',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 15.h),
                CustomButtonWidget(
                  onTap: () {
                    final cubit = context.read<CourseCubit>();
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: cubit,
                        child: const FiltersBottomSheetWidget(),
                      ),
                    );
                  },
                  title: "Edite Fillter",
                  titleStyle: AppTextStyles.s16w500.copyWith(
                    color: AppColors.titlePrimary,
                  ),
                  buttonColor: AppColors.buttonPrimary,
                  borderColor: AppColors.borderPrimary,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
