import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    if (options.isEmpty) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${questionNumber.padLeft(2, '0')} - $questionTitle",
              style: AppTextStyles.s16w500.copyWith(color: AppColors.textBlack),
            ),
            12.sizedH,

            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
              decoration: BoxDecoration(
                color: AppColors.formGreyPro.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.formGreyPro.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.iconError,
                    size: 24.sp,
                  ),
                  10.sizedW,
                  Text(
                    "No options available for this question.",
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textError,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        10.sizedH,
        Column(
          children: List.generate(options.length, (index) {
            final option = options[index];
            final isSelected = selectedOptionIndex == index;

            return InkWell(
              onTap: () {
                onOptionSelected(index);
              },
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
                    12.sizedW,
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
