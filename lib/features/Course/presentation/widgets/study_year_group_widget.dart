// import 'package:e_learning/features/auth/data/models/study_year_enum.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:e_learning/core/colors/app_colors.dart';
// import 'package:e_learning/core/style/app_text_styles.dart';

// class StudyYearGroupWidget extends StatelessWidget {
//   final bool Function(String) isSelected;
//   final void Function(String) toggleSelection;

//   const StudyYearGroupWidget({
//     super.key,
//     required this.isSelected,
//     required this.toggleSelection,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final studyYears = SchoolYear.values;

//     return Padding(
//       padding: EdgeInsets.only(bottom: 20.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Study Year",
//             style: AppTextStyles.s16w600.copyWith(color: AppColors.textPrimary),
//           ),
//           SizedBox(height: 10.h),
//           Wrap(
//             spacing: 8.w,
//             runSpacing: 8.h,
//             children: studyYears.map((year) {
//               final name = year.displayName(context);
//               final selected = isSelected(name);

//               return GestureDetector(
//                 onTap: () => toggleSelection(name),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   curve: Curves.easeInOut,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 16.w,
//                     vertical: 8.h,
//                   ),
//                   decoration: BoxDecoration(
//                     color: selected
//                         ? AppColors.buttonTapSelected
//                         : AppColors.buttonTapNotSelected,
//                     borderRadius: BorderRadius.circular(20.r),
//                     boxShadow: selected
//                         ? [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 5,
//                               offset: const Offset(0, 2),
//                             ),
//                           ]
//                         : [],
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       AnimatedOpacity(
//                         opacity: selected ? 1 : 0,
//                         duration: const Duration(milliseconds: 200),
//                         child: Icon(
//                           Icons.check,
//                           size: 18.sp,
//                           color: AppColors.textWhite,
//                         ),
//                       ),
//                       if (selected) SizedBox(width: 6.w),
//                       Text(
//                         name,
//                         style: AppTextStyles.s14w500.copyWith(
//                           color: selected
//                               ? AppColors.textWhite
//                               : AppColors.textPrimary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:e_learning/features/auth/data/models/study_year_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class StudyYearGroupWidget extends StatelessWidget {
  final bool Function(String) isSelected;
  final void Function(String) toggleSelection;

  const StudyYearGroupWidget({
    super.key,
    required this.isSelected,
    required this.toggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    final studyYears = SchoolYear.values;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Study Year",
            style: AppTextStyles.s16w600.copyWith(color: AppColors.textPrimary),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: studyYears.map((year) {
              final name = year.displayName(context);
              final selected = isSelected(name);

              return GestureDetector(
                onTap: () => toggleSelection(name),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.buttonTapSelected
                        : AppColors.buttonTapNotSelected,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedOpacity(
                        opacity: selected ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.check,
                          size: 18.sp,
                          color: AppColors.textWhite,
                        ),
                      ),
                      if (selected) SizedBox(width: 6.w),
                      Text(
                        name,
                        style: AppTextStyles.s14w500.copyWith(
                          color: selected
                              ? AppColors.textWhite
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
