// import 'package:e_learning/core/colors/app_colors.dart';
// import 'package:e_learning/core/style/app_padding.dart';
// import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
// import 'package:e_learning/core/widgets/chips_bar.dart';
// import 'package:e_learning/core/widgets/custom_error_widget.dart';
// import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
// import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
// import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
// import 'package:e_learning/features/Course/presentation/widgets/filter_widget.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class CustomCategoryTabBarWidget extends StatelessWidget {
//   const CustomCategoryTabBarWidget({super.key, this.withFilter = true});

//   final bool withFilter;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CourseCubit, CourseState>(
//       builder: (context, state) {
//         final colleges = state.colleges ?? [];
//         final labels = colleges.map((college) => college.name).toList();

//         // Loading state
//         if (state.collegesStatus == ResponseStatusEnum.loading) {
//           return Column(
//             children: [
//               Padding(
//                 padding: AppPadding.appPadding.copyWith(end: 0),
//                 child: Skeletonizer(
//                   enabled: true,
//                   child: ChipsBar(
//                     labels: List.generate(5, (index) => 'loading'.tr()),
//                     onChipSelected: (value) {},
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),
//               Expanded(
//                 child: ListView.separated(
//                   padding: AppPadding.appPadding,
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: 5,
//                   itemBuilder: (context, index) {
//                     return Skeletonizer(
//                       enabled: true,
//                       child: CourseInfoCardWidget(
//                         title: 'loading_course_title'.tr(),
//                         subtitle: 'loading_college_name'.tr(),
//                         rating: 0,
//                         price: '0',
//                       ),
//                     );
//                   },
//                   separatorBuilder: (_, __) => SizedBox(height: 15.h),
//                 ),
//               ),
//             ],
//           );
//         }

//         // Error state
//         if (state.collegesStatus == ResponseStatusEnum.failure) {
//           print(state.collegesError);
//           return const CustomErrorWidget();
//         }

//         // Main content - just show UI and courses list
//         return Column(
//           children: [
//             Padding(
//               padding: AppPadding.appPadding.copyWith(end: 0),
//               child: Row(
//                 children: [
//                   // Filter button UI only (no functionality)
//                   if (withFilter)
//                     IconButton(
//                       icon: Icon(
//                         Icons.tune,
//                         color: AppColors.primaryTextColor,
//                       ),
//                       onPressed: () {
//                         // No functionality - just UI
//                       },
//                     ),
//                   // ChipsBar UI only (no functionality)
//                   Expanded(
//                     child: labels.isEmpty
//                         ? const SizedBox.shrink()
//                         : ChipsBar(
//                             labels: labels,
//                             onChipSelected: (value) {
//                               // No functionality - just UI
//                             },
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),
//             // Just show all courses - no filtering
//             Expanded(
//               child: const FilterWidget(),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/filter_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/filtered_courses_list_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/filters_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

// class CustomCategoryTabBarWidget extends StatelessWidget {
//   const CustomCategoryTabBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CourseCubit, CourseState>(
//       buildWhen: (pre, curr) {
//         return pre.collegesStatus != curr.collegesStatus ||
//             pre.coursesStatus != curr.coursesStatus ||
//             pre.selectedIndex != curr.selectedIndex;
//       },
//       builder: (context, state) {
//         final selectedIndex = state.selectedIndex;

//         if (state.collegesStatus == ResponseStatusEnum.loading ||
//             state.coursesStatus == ResponseStatusEnum.loading) {
//           return Column(
//             children: [
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
//                 child: Row(
//                   children: List.generate(
//                     5,
//                     (_) => AppLoading.skeleton(width: 80, height: 35),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),
//               Expanded(
//                 child: ListView.separated(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: 3,
//                   itemBuilder: (context, index) => const CourseInfoCardWidget(
//                     title: '',
//                     subtitle: '',
//                     rating: 0,
//                     price: '',
//                     isLoading: true,
//                   ),
//                   separatorBuilder: (_, __) => SizedBox(height: 15.h),
//                 ),
//               ),
//             ],
//           );
//         }

//         if (state.collegesStatus == ResponseStatusEnum.failure) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.error_outline,
//                   size: 50.sp,
//                   color: AppColors.iconError,
//                 ),
//                 SizedBox(height: 12.h),
//                 Text(
//                   state.collegesError ?? 'Something went wrong',
//                   style: AppTextStyles.s16w500.copyWith(
//                     color: AppColors.textError,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 20.h),
//                 CustomButtonWidget(
//                   onTap: () {
//                     context.read<CourseCubit>().getColleges();
//                     context.read<CourseCubit>().getCourses();
//                   },
//                   title: "Retry",
//                   titleStyle: AppTextStyles.s16w500.copyWith(
//                     color: AppColors.titlePrimary,
//                   ),
//                   buttonColor: AppColors.buttonPrimary,
//                   borderColor: AppColors.borderPrimary,
//                 ),
//               ],
//             ),
//           );
//         }

//         final college = state.colleges ?? [];
//         final courses = state.courses?.courses ?? [];
//         if (courses.isNotEmpty) {
//           return Column(
//             children: [
//               SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
//                 child: Row(
//                   children: List.generate(college.length + 1, (index) {
//                     final bool isSelected = index == selectedIndex;
//                     final tabName = index == 0 ? '' : college[index - 1].name;

//                     return GestureDetector(
//                       onTap: () {
//                         context.read<CourseCubit>().changeSelectedIndex(index);
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 250),
//                         curve: Curves.easeInOut,
//                         margin: EdgeInsets.symmetric(horizontal: 8.w),
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 16.w,
//                           vertical: 8.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? AppColors.buttonTapSelected
//                               : AppColors.buttonTapNotSelected,
//                           borderRadius: BorderRadius.circular(20.r),
//                         ),
//                         child: Row(
//                           children: [
//                             if (index == 0)
//                               GestureDetector(
//                                 onTap: () {
//                                   context
//                                       .read<CourseCubit>()
//                                       .changeSelectedIndex(0);
//                                 },
//                                 onLongPress: () {
//                                   final cubit = context.read<CourseCubit>();
//                                   cubit.getCategories();
//                                   cubit.getStudyYears();
//                                   showModalBottomSheet(
//                                     isScrollControlled: true,
//                                     context: context,
//                                     builder: (_) => BlocProvider.value(
//                                       value: cubit,
//                                       child: const FiltersBottomSheetWidget(),
//                                     ),
//                                   );
//                                 },
//                                 child: Padding(
//                                   padding: EdgeInsets.only(right: 8.w),
//                                   child: Icon(
//                                     Icons.tune,
//                                     size: 20.sp,
//                                     color: isSelected
//                                         ? AppColors.iconWhite
//                                         : AppColors.iconBlue,
//                                   ),
//                                 ),
//                               ),

//                             if (tabName.isNotEmpty)
//                               Text(
//                                 tabName,
//                                 style: AppTextStyles.s14w400.copyWith(
//                                   color: isSelected
//                                       ? AppColors.textWhite
//                                       : AppColors.textPrimary,
//                                   fontWeight: isSelected
//                                       ? FontWeight.w600
//                                       : FontWeight.w400,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//               SizedBox(height: 8.h),
//               Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),
//               Expanded(
//                 child: selectedIndex == 0
//                     ? const FilterWidget()
//                     : FilteredCoursesListWidget(
//                         courses: (selectedIndex == 0)
//                             ? state.courses?.courses ?? []
//                             : (state.courses?.courses ?? [])
//                                   .where(
//                                     (course) =>
//                                         course.college ==
//                                         (state
//                                                 .colleges?[selectedIndex - 1]
//                                                 .id ??
//                                             0),
//                                   )
//                                   .map(
//                                     (course) =>
//                                         state.courses?.courses?.firstWhere(
//                                           (c) => c.id == course.id,
//                                           orElse: () => course,
//                                         ) ??
//                                         course,
//                                   )
//                                   .toList(),
//                       ),
//               ),
//             ],
//           );
//         } else {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.menu_book_outlined,
//                   size: 50.sp,
//                   color: AppColors.iconBlue,
//                 ),
//                 SizedBox(height: 12.h),
//                 Text(
//                   'No courses available',
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 15.h),
//                 CustomButtonWidget(
//                   onTap: () {
//                     final cubit = context.read<CourseCubit>();
//                     showModalBottomSheet(
//                       isScrollControlled: true,
//                       context: context,
//                       builder: (_) => BlocProvider.value(
//                         value: cubit,
//                         child: const FiltersBottomSheetWidget(),
//                       ),
//                     );
//                   },
//                   title: "Edite Fillter",
//                   titleStyle: AppTextStyles.s16w500.copyWith(
//                     color: AppColors.titlePrimary,
//                   ),
//                   buttonColor: AppColors.buttonPrimary,
//                   borderColor: AppColors.borderPrimary,
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class CustomCategoryTabBarWidget extends StatelessWidget {
  const CustomCategoryTabBarWidget({super.key, this.withFilter = true});

  final bool withFilter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        final colleges = state.colleges ?? [];
        final labels = colleges.map((college) => college.name).toList();

        // ------------------ Loading State ------------------
        if (state.collegesStatus == ResponseStatusEnum.loading ||
            state.coursesStatus == ResponseStatusEnum.loading) {
          return Column(
            children: [
              Padding(
                padding: AppPadding.appPadding.copyWith(end: 0),
                child: Skeletonizer(
                  enabled: true,
                  child: ChipsBar(
                    labels: List.generate(5, (index) => 'loading'.tr()),
                    onChipSelected: (value) {},
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),
              Expanded(
                child: ListView.separated(
                  padding: AppPadding.appPadding,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: CourseInfoCardWidget(
                        title: 'loading_course_title'.tr(),
                        subtitle: 'loading_college_name'.tr(),
                        rating: 0,
                        price: '0',
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 15.h),
                ),
              ),
            ],
          );
        }

        // ------------------ Failure State ------------------
        if (state.collegesStatus == ResponseStatusEnum.failure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 50.sp,
                  color: AppColors.iconError,
                ),
                SizedBox(height: 12.h),
                Text(
                  state.collegesError ?? 'Something went wrong',
                  style: AppTextStyles.s16w500.copyWith(
                    color: AppColors.textError,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
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

        // ------------------ Loaded Successfully ------------------
        final courses = state.courses?.courses ?? [];

        return Column(
          children: [
            // ----------- Icon + Tabs Row -----------
            Row(
              children: [
                // ---------------- Filter Icon ----------------
                GestureDetector(
                  onTap: () {
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
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.buttonTapNotSelected,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Icons.tune,
                      size: 20.sp,
                      color: AppColors.iconBlue,
                    ),
                  ),
                ),

                // ---------------- Tabs ----------------
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 6.h,
                    ),
                    child: Row(
                      children: List.generate(colleges.length + 1, (index) {
                        final bool isSelected = index == state.selectedIndex;

                        final String tabName =
                            index == 0 ? "All" : colleges[index - 1].name;

                        return GestureDetector(
                          onTap: () {
                            context.read<CourseCubit>().changeSelectedIndex(
                                  index,
                                );
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
                            child: Text(
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
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),
            Divider(color: AppColors.dividerGrey, thickness: 1, height: 0.h),

            // ---------------- Tabs Content ----------------
            Expanded(
              child: state.selectedIndex == 0
                  ? const FilterWidget()
                  : FilteredCoursesListWidget(
                      courses: courses
                          .where(
                            (c) =>
                                c.college ==
                                (colleges[state.selectedIndex - 1].id),
                          )
                          .toList(),
                    ),
            ),
          ],
        );
      },
    );
  }
}
