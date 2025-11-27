import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/services/storage/hivi/hive_service.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/app_message.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:e_learning/features/course/presentation/widgets/filter_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiltersBottomSheetWidget extends StatefulWidget {
  const FiltersBottomSheetWidget({super.key});

  @override
  State<FiltersBottomSheetWidget> createState() =>
      _FiltersBottomSheetWidgetState();
}

class _FiltersBottomSheetWidgetState extends State<FiltersBottomSheetWidget> {
  int? tempCollege;
  int? tempCategory;
  int? tempYear;
  bool _hasApplied = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CourseCubit>();
    final state = cubit.state;

    final cachedFilters =
        state.coursefilters ?? di<HiveService>().getCourseFiltersHive();
    tempCollege = cachedFilters?.collegeId;
    tempCategory = cachedFilters?.categoryId;
    tempYear = cachedFilters?.studyYear;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listenWhen: (previous, current) =>
          previous.coursesStatus != current.coursesStatus ||
          previous.collegesStatus != current.collegesStatus ||
          previous.categoriesStatus != current.categoriesStatus ||
          previous.studyYearsStatus != current.studyYearsStatus,
      listener: (context, state) {
        if (_hasApplied) {
          if (state.coursesStatus == ResponseStatusEnum.success) {
            di<HiveService>().saveCourseFiltersHive(
              CourseFiltersModel(
                collegeId: tempCollege,
                categoryId: tempCategory,
                studyYear: tempYear,
              ),
            );
            if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          } else if (state.coursesStatus == ResponseStatusEnum.failure) {
            // عرض رسالة خطأ فقط
            AppMessage.showError(context, "Failed to apply filters. Please try again.");
          }
        }
      },
      buildWhen: (previous, current) =>
          previous.colleges != current.colleges ||
          previous.categories != current.categories ||
          previous.studyYears != current.studyYears ||
          previous.collegesStatus != current.collegesStatus ||
          previous.categoriesStatus != current.categoriesStatus ||
          previous.studyYearsStatus != current.studyYearsStatus,
      builder: (context, state) {
        final isLoading =
            (state.collegesStatus != ResponseStatusEnum.success &&
                state.collegesStatus != ResponseStatusEnum.failure) ||
            (state.categoriesStatus != ResponseStatusEnum.success &&
                state.categoriesStatus != ResponseStatusEnum.failure) ||
            (state.studyYearsStatus != ResponseStatusEnum.success &&
                state.studyYearsStatus != ResponseStatusEnum.failure);

        final hasError =
            state.collegesStatus == ResponseStatusEnum.failure ||
            state.categoriesStatus == ResponseStatusEnum.failure ||
            state.studyYearsStatus == ResponseStatusEnum.failure;

        if (isLoading) {
          return _buildLoadingUI();
        }

        if (hasError) {
          return _buildErrorUI(state);
        }

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
    final errorMessages = [
      if (state.collegesError != null) state.collegesError,
      if (state.categoriesError != null) state.categoriesError,
      if (state.studyYearsError != null) state.studyYearsError,
    ].join('\n');

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
              errorMessages.isNotEmpty ? errorMessages : 'Something went wrong',
              textAlign: TextAlign.center,
              style: AppTextStyles.s16w500.copyWith(color: AppColors.textError),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              title: "Retry",
              buttonColor: AppColors.buttonPrimary,
              onTap: () {
                final cubit = context.read<CourseCubit>();
                cubit.getColleges();
                cubit.getCategories();
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
    final colleges = state.colleges ?? [];
    final categories = state.categories ?? [];
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
                    title: "College",
                    items: colleges
                        .map((c) => FilterItem(id: c.id, name: c.name))
                        .toList(),
                    selectedId: tempCollege,
                    onSelect: (value) => setState(() => tempCollege = value),
                  ),
                  FilterGroupWidget(
                    title: "Categories",
                    items: categories
                        .map((c) => FilterItem(id: c.id, name: c.name))
                        .toList(),
                    selectedId: tempCategory,
                    onSelect: (value) => setState(() => tempCategory = value),
                  ),
                  FilterGroupWidget(
                    title: "Study Year",
                    items: studyYears
                        .map((c) => FilterItem(id: c.id, name: c.name))
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
                  child: CustomButton(
                    title: "Cancel",
                    buttonColor: AppColors.buttonWhite,
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    title: "Apply",
                    buttonColor: AppColors.buttonPrimary,
                    onTap: () {
                      _hasApplied = true;
                      courseCubit.applyFiltersByIds(
                        collegeId: tempCollege,
                        categoryId: tempCategory,
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
