import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class QuizQuestionWidget extends StatelessWidget {
  final String questionNumber;
  final String questionTitle;
  final String points;
  final List<String> options;
  final ValueChanged<int> onOptionSelected;
  final int? selectedOptionIndex;

  const QuizQuestionWidget({
    super.key,
    required this.questionNumber,
    required this.selectedOptionIndex,
    required this.questionTitle,
    required this.points,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    // حماية في حال الخيارات فارغة
    if (options.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${questionNumber.padLeft(2, '0')} - $questionTitle",
            style: AppTextStyles.s16w500.copyWith(color: AppColors.textBlack),
          ),
          SizedBox(height: 10.h),
          Text(
            "No options available",
            style: AppTextStyles.s14w400.copyWith(color: AppColors.textError),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${questionNumber.padLeft(2, '0')} - $questionTitle",
                style: AppTextStyles.s16w500.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
            ),
            Text(
              "$points Points",
              style: AppTextStyles.s14w400.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Column(
          children: List.generate(options.length, (index) {
            final option = options[index];
            final isSelected = selectedOptionIndex == index;

            return InkWell(
              onTap: () => onOptionSelected(index),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.textPrimary
                            : AppColors.backgroundWhiteWidget,
                        border: Border.all(
                          color: AppColors.borderBrand,
                          width: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        option,
                        style: AppTextStyles.s14w400.copyWith(
                          color: isSelected
                              ? AppColors.textPrimary
                              : AppColors.textBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// class QuizQuestionWidget extends StatelessWidget {
//   final String questionNumber;
//   final String questionTitle;
//   final String points;
//   final List<String> options;
//   final ValueChanged<int> onOptionSelected;
//   final int? selectedOptionIndex;

//   const QuizQuestionWidget({
//     super.key,
//     required this.questionNumber,
//     required this.selectedOptionIndex,
//     required this.questionTitle,
//     required this.points,
//     required this.options,
//     required this.onOptionSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 "${questionNumber.padLeft(2, '0')} - $questionTitle",
//                 style: AppTextStyles.s16w500.copyWith(
//                   color: AppColors.textBlack,
//                 ),
//               ),
//             ),
//             Text(
//               "$points Points",
//               style: AppTextStyles.s14w400.copyWith(
//                 color: AppColors.textPrimary,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 10.h),
//         Column(
//           children: List.generate(options.length, (index) {
//             final option = options[index];
//             final isSelected = selectedOptionIndex == index;

//             return InkWell(
//               onTap: () => onOptionSelected(index),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10.h),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 18.w,
//                       height: 18.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: isSelected
//                             ? AppColors.textPrimary
//                             : AppColors.backgroundWhiteWidget,
//                         border: Border.all(
//                           color: AppColors.borderBrand,
//                           width: 1.5,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12.w),
//                     Expanded(
//                       child: Text(
//                         option,
//                         style: AppTextStyles.s14w400.copyWith(
//                           color: isSelected
//                               ? AppColors.textPrimary
//                               : AppColors.textBlack,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
