import 'dart:developer';

import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model.dart';
import 'package:e_learning/features/Course/presentation/widgets/filter_group_widget.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:e_learning/features/course/presentation/widgets/filter_group_widget.dart'
    hide FilterItem, FilterGroupWidget;
import 'package:e_learning/features/course/presentation/widgets/study_year_group_widget.dart';
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
  String? selectedUniversity;
  int? selectedCollege;
  int? selectedYear;

  @override
  void initState() {
    super.initState();
    final filters = context.read<CourseCubit>().state.coursefilters;

    // تعيين القيم الأولية من state
    selectedUniversity = filters?.university;
    selectedCollege = filters?.collegeId;
    selectedYear = filters?.studyYear;
  }

  void selectUniversity(String? value) {
    setState(() {
      selectedUniversity = value == selectedUniversity ? null : value;
    });
  }

  void selectCollege(int? value) {
    setState(() {
      selectedCollege = value == selectedCollege ? null : value;
    });
  }

  void selectYear(int? value) {
    setState(() {
      selectedYear = value == selectedYear ? null : value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (context, state) {},
      builder: (context, state) {
        final universities = state.universities ?? [];
        final colleges = state.colleges ?? [];

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
                      // Universities
                      // FilterGroupWidget(
                      //   title: "University",
                      //   items: universities
                      //       .map((u) => FilterItem(id: u.id, name: u.name))
                      //       .toList(),
                      //   selectedId: 0,
                      //   //  selectedUniversity.to
                      //   onSelect: selectUniversity,
                      // ),

                      // Colleges
                      FilterGroupWidget(
                        title: "College",
                        items: colleges
                            .map((c) => FilterItem(id: c.id, name: c.name))
                            .toList(),
                        selectedId: selectedCollege,
                        onSelect: selectCollege,
                      ),

                      // Study Year
                      StudyYearGroupWidget(
                        selectedYear: selectedYear,

                        onSelect: (yearNumber) {
                          setState(() {
                            selectedYear = yearNumber;
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
                        onTap: () => Navigator.of(context).pop(),
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
                          final collegeId = selectedCollege;

                          final yearId = selectedYear;

                          log(
                            "Applying filters UI : college=$collegeId, studyYear=$yearId",
                          );

                          context.read<CourseCubit>().applyFilters(
                            CourseFiltersModel(
                              collegeId: collegeId,
                              studyYear: yearId, // <-- أرسلها هنا
                            ),
                          );

                          Navigator.of(context).pop();
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
