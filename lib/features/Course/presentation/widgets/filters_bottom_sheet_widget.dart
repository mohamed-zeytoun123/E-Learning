import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/filter_group_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/study_year_group_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiltersBottomSheetWidget extends StatefulWidget {
  const FiltersBottomSheetWidget({super.key});

  @override
  State<FiltersBottomSheetWidget> createState() =>
      _FiltersBottomSheetWidgetState();
}

class _FiltersBottomSheetWidgetState extends State<FiltersBottomSheetWidget> {
  final List<String> universities = [
    "Damascus",
    "Aleppo",
    "Tishreen",
    "Al-Baath",
  ];

  final List<String> colleges = ["Engineering", "Science", "IT", "Medicine"];

  final Set<String> selectedFilters = {};

  bool isSelected(String value) => selectedFilters.contains(value);

  void toggleSelection(String value) {
    setState(() {
      if (isSelected(value)) {
        selectedFilters.remove(value);
      } else {
        selectedFilters.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        mainAxisSize: MainAxisSize.min,
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
                    title: "university".tr(),
                    items: universities,
                    isSelected: isSelected,
                    toggleSelection: toggleSelection,
                  ),
                  FilterGroupWidget(
                    title: "college".tr(),
                    items: colleges,
                    isSelected: isSelected,
                    toggleSelection: toggleSelection,
                  ),
                  StudyYearGroupWidget(
                    isSelected: isSelected,
                    toggleSelection: toggleSelection,
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
                      Navigator.of(context).pop();
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
                      // إغلاق مع تمرير الفلاتر المختارة للصفحة الأم
                      // Navigator.of(context).pop(selectedFilters);
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
