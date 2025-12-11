// import 'package:e_learning/core/colors/app_colors.dart';
// import 'package:e_learning/core/style/app_text_styles.dart';
// import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
// import 'package:e_learning/features/course/presentation/widgets/filter_group_widget.dart';
// import 'package:e_learning/features/course/presentation/widgets/study_year_group_widget.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class FiltersBottomSheetWidget extends StatefulWidget {
//   const FiltersBottomSheetWidget({super.key});

//   @override
//   State<FiltersBottomSheetWidget> createState() =>
//       _FiltersBottomSheetWidgetState();
// }

// class _FiltersBottomSheetWidgetState extends State<FiltersBottomSheetWidget> {
//   final List<String> universities = [
//     "Damascus",
//     "Aleppo",
//     "Tishreen",
//     "Al-Baath",
//   ];

//   final List<String> colleges = ["Engineering", "Science", "IT", "Medicine"];

//   final Set<String> selectedFilters = {};

//   bool isSelected(String value) => selectedFilters.contains(value);

//   void toggleSelection(String value) {
//     setState(() {
//       if (isSelected(value)) {
//         selectedFilters.remove(value);
//       } else {
//         selectedFilters.add(value);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 565.h,
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: AppColors.textWhite,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(32),
//           topRight: Radius.circular(32),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 80.w,
//             height: 8.h,
//             decoration: BoxDecoration(
//               color: AppColors.dividerWhite,
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             "Filters",
//             style: AppTextStyles.s18w600.copyWith(color: AppColors.textPrimary),
//           ),
//           SizedBox(height: 16.h),
//           Expanded(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   FilterGroupWidget(
//                     title: "university".tr(),
//                     items: universities,
//                     isSelected: isSelected,
//                     toggleSelection: toggleSelection,
//                   ),
//                   FilterGroupWidget(
//                     title: "college".tr(),
//                     items: colleges,
//                     isSelected: isSelected,
//                     toggleSelection: toggleSelection,
//                   ),
//                   StudyYearGroupWidget(
//                     isSelected: isSelected,
//                     toggleSelection: toggleSelection,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
//             child: Row(
//               spacing: 15.w,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Expanded(
//                   child: CustomButtonWidget(
//                     title: "cancel".tr(),
//                     titleStyle: AppTextStyles.s16w500.copyWith(
//                       color: AppColors.textPrimary,
//                     ),
//                     buttonColor: AppColors.buttonWhite,
//                     borderColor: AppColors.borderPrimary,
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomButtonWidget(
//                     title: "apply".tr(),
//                     titleStyle: AppTextStyles.s16w500.copyWith(
//                       color: AppColors.textWhite,
//                     ),
//                     buttonColor: AppColors.buttonPrimary,
//                     borderColor: AppColors.borderPrimary,
//                     onTap: () {
//                       // إغلاق مع تمرير الفلاتر المختارة للصفحة الأم
//                       // Navigator.of(context).pop(selectedFilters);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/services/storage/hivi/hive_service.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/filter_group_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiltersBottomSheetWidget extends StatefulWidget {
  final void Function(CourseFiltersModel?)? onFiltersApplied;
  
  const FiltersBottomSheetWidget({
    super.key,
    this.onFiltersApplied,
  });

  @override
  State<FiltersBottomSheetWidget> createState() =>
      _FiltersBottomSheetWidgetState();
}

class _FiltersBottomSheetWidgetState extends State<FiltersBottomSheetWidget> {
  int? tempUniversity;
  int? tempCollege;
  int? tempYear;
  bool _hasApplied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final cubit = context.read<CourseCubit>();
        final state = cubit.state;

        // Load universities if not already loaded or loading
        if ((state.universities == null || state.universities!.isEmpty) &&
            state.universitiesState != ResponseStatusEnum.loading) {
          cubit.getUniversities();
        }
        // Load colleges if not already loaded or loading
        if ((state.colleges == null || state.colleges!.isEmpty) &&
            state.collegesStatus != ResponseStatusEnum.loading) {
          cubit.getColleges();
        }
        // Load study years if not already loaded or loading
        if ((state.studyYears == null || state.studyYears!.isEmpty) &&
            state.studyYearsStatus != ResponseStatusEnum.loading) {
          cubit.getStudyYears();
        }

        final cachedFilters =
            state.coursefilters ?? appLocator<HiveService>().getCourseFiltersHive();
        tempUniversity = cachedFilters?.universityId;
        tempCollege = cachedFilters?.collegeId;
        tempYear = cachedFilters?.studyYear;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listenWhen: (previous, current) =>
          previous.coursesStatus != current.coursesStatus ||
          previous.collegesStatus != current.collegesStatus ||
          previous.universitiesState != current.universitiesState ||
          previous.studyYearsStatus != current.studyYearsStatus,
      listener: (context, state) {
        if (_hasApplied) {
          if (state.coursesStatus == ResponseStatusEnum.success) {
            final filters = CourseFiltersModel(
              universityId: tempUniversity,
              collegeId: tempCollege,
              studyYear: tempYear,
            );
            appLocator<HiveService>().saveCourseFiltersHive(filters);
            // Call the callback if provided
            if (widget.onFiltersApplied != null) {
              widget.onFiltersApplied!(filters);
            }
            if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          } else if (state.coursesStatus == ResponseStatusEnum.failure) {
            // عرض رسالة خطأ فقط
            AppMessage.showFlushbar(
              context: context,
              title: "Error",
              message: "Failed to apply filters. Please try again.",
              iconData: Icons.error,
              backgroundColor: AppColors.messageError,
              iconColor: AppColors.iconWhite,
              isShowProgress: true,
              duration: Duration(seconds: 5),
            );
          }
        }
      },
      buildWhen: (previous, current) =>
          previous.colleges != current.colleges ||
          previous.universities != current.universities ||
          previous.studyYears != current.studyYears ||
          previous.collegesStatus != current.collegesStatus ||
          previous.universitiesState != current.universitiesState ||
          previous.studyYearsStatus != current.studyYearsStatus,
      builder: (context, state) {
        // Check if any are still loading or initial
        final isLoading = state.collegesStatus == ResponseStatusEnum.loading ||
            state.collegesStatus == ResponseStatusEnum.initial ||
            state.universitiesState == ResponseStatusEnum.loading ||
            state.universitiesState == ResponseStatusEnum.initial ||
            state.studyYearsStatus == ResponseStatusEnum.loading ||
            state.studyYearsStatus == ResponseStatusEnum.initial;

        // Only show error if we've actually tried to load (not initial) and got a failure
        final hasError = !isLoading &&
            (state.collegesStatus == ResponseStatusEnum.failure ||
                state.universitiesState == ResponseStatusEnum.failure ||
                state.studyYearsStatus == ResponseStatusEnum.failure);

        // Show loading if any are still loading or initial
        if (isLoading) {
          return _buildLoadingUI();
        }

        // Show error only if we're not loading and have a failure
        if (hasError) {
          return _buildErrorUI(state);
        }

        // Show filters UI if we have at least one successful load
        // (even if some lists are empty, that's okay)
        return _buildFiltersUI(state);
      },
    );
  }

  Widget _buildLoadingUI() {
    return Container(
      height: 200.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.buttonPrimary),
      ),
    );
  }

  Widget _buildErrorUI(CourseState state) {
    final errorMessages = <String>[];
    if (state.collegesError != null && 
        state.collegesError!.isNotEmpty &&
        !state.collegesError!.toLowerCase().contains('no data')) {
      errorMessages.add(state.collegesError!);
    }
    if (state.universitiesError != null && 
        state.universitiesError!.isNotEmpty &&
        !state.universitiesError!.toLowerCase().contains('no data')) {
      errorMessages.add(state.universitiesError!);
    }
    if (state.studyYearsError != null && 
        state.studyYearsError!.isNotEmpty &&
        !state.studyYearsError!.toLowerCase().contains('no data')) {
      errorMessages.add(state.studyYearsError!);
    }

    // If all errors are "no data" or empty, show filters UI with empty lists instead
    if (errorMessages.isEmpty) {
      return _buildFiltersUI(state);
    }

    return Container(
      height: 200.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 50.sp, color: AppColors.textError),
            SizedBox(height: 12.h),
            Text(
              errorMessages.join('\n'),
              textAlign: TextAlign.center,
              style: AppTextStyles.s16w500.copyWith(color: AppColors.textError),
            ),
            SizedBox(height: 20.h),
            CustomButtonWidget(
              title: "Retry",
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.titlePrimary,
              ),
              buttonColor: AppColors.buttonPrimary,
              borderColor: AppColors.borderPrimary,
              onTap: () {
                final cubit = context.read<CourseCubit>();
                cubit.getUniversities();
                cubit.getColleges();
                cubit.getStudyYears();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersUI(CourseState state) {
    final courseCubit = context.read<CourseCubit>();
    final universities = state.universities ?? [];
    final colleges = state.colleges ?? [];
    final studyYears = state.studyYears ?? [];

    return Container(
      height: 565.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.textWhite,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: AppColors.dividerWhite,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Filters",
            style: AppTextStyles.s18w600.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterGroupWidget(
                    title: "University",
                    items: universities
                        .map((u) => FilterItem(id: u.id, name: u.name))
                        .toList(),
                    selectedId: tempUniversity,
                    onSelect: (value) => setState(() => tempUniversity = value),
                  ),
                  FilterGroupWidget(
                    title: "College",
                    items: colleges
                        .map((c) => FilterItem(id: c.id, name: c.name))
                        .toList(),
                    selectedId: tempCollege,
                    onSelect: (value) => setState(() => tempCollege = value),
                  ),
                  FilterGroupWidget(
                    title: "Study Year",
                    items: studyYears
                        .map((y) => FilterItem(id: y.id, name: y.name))
                        .toList(),
                    selectedId: tempYear,
                    onSelect: (value) => setState(() => tempYear = value),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: Row(
              spacing: 15.w,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomButtonWidget(
                    title: "cancel".tr(),
                    titleStyle: AppTextStyles.s16w500.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    buttonColor: AppColors.buttonWhite,
                    borderColor: AppColors.borderPrimary,
                    onTap: () {
                      final courseCubit = context.read<CourseCubit>();
                      // Clear all filters
                      courseCubit.applyFiltersByIds(
                        universityId: null,
                        collegeId: null,
                        studyYear: null,
                      );
                      // Call the callback with null to clear filters in SearchCubit if used from search
                      if (widget.onFiltersApplied != null) {
                        widget.onFiltersApplied!(null);
                      }
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: CustomButtonWidget(
                    title: "apply".tr(),
                    titleStyle: AppTextStyles.s16w500.copyWith(
                      color: AppColors.textWhite,
                    ),
                    buttonColor: AppColors.buttonPrimary,
                    borderColor: AppColors.borderPrimary,
                    onTap: () {
                      _hasApplied = true;
                      courseCubit.applyFiltersByIds(
                        universityId: tempUniversity,
                        collegeId: tempCollege,
                        studyYear: tempYear,
                      );
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
