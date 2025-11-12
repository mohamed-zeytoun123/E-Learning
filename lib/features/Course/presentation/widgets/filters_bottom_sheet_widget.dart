import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/services/storage/hivi/hive_service.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:e_learning/features/course/presentation/widgets/filter_group_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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

  @override
  @override
  void initState() {
    super.initState();
    final cubit = context.read<CourseCubit>();
    final state = cubit.state;

    appLocator<HiveService>().getCourseFiltersHive();
    final cachedFilters =
        state.coursefilters ?? appLocator<HiveService>().getCourseFiltersHive();

    tempCollege = cachedFilters?.collegeId;
    tempCategory = cachedFilters?.categoryId;
    tempYear = cachedFilters?.studyYear;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        final isLoading =
            state.collegesStatus != ResponseStatusEnum.success ||
            state.categoriesStatus != ResponseStatusEnum.success ||
            state.studyYearsStatus != ResponseStatusEnum.success;

        if (isLoading) {
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
                style: AppTextStyles.s18w600.copyWith(
                  color: AppColors.textPrimary,
                ),
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
                        onSelect: (value) {
                          setState(() {
                            tempCollege = value;
                          });
                        },
                      ),
                      FilterGroupWidget(
                        title: "Categories",
                        items: categories
                            .map((c) => FilterItem(id: c.id, name: c.name))
                            .toList(),
                        selectedId: tempCategory,
                        onSelect: (value) {
                          setState(() {
                            tempCategory = value;
                          });
                        },
                      ),
                      FilterGroupWidget(
                        title: "Study Year",
                        items: studyYears
                            .map((c) => FilterItem(id: c.id, name: c.name))
                            .toList(),
                        selectedId: tempYear,
                        onSelect: (value) {
                          setState(() {
                            tempYear = value;
                          });
                        },
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
                        title: "Cancel",
                        titleStyle: AppTextStyles.s16w500.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        buttonColor: AppColors.buttonWhite,
                        borderColor: AppColors.borderPrimary,
                        onTap: () => context.pop(),
                      ),
                    ),
                    Expanded(
                      child: CustomButtonWidget(
                        title: "Apply",
                        titleStyle: AppTextStyles.s16w500.copyWith(
                          color: AppColors.textWhite,
                        ),
                        buttonColor: AppColors.buttonPrimary,
                        borderColor: AppColors.borderPrimary,
                        onTap: () {
                          courseCubit.applyFiltersByIds(
                            collegeId: tempCollege,
                            categoryId: tempCategory,
                            studyYear: tempYear,
                          );
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
