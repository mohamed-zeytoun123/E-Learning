import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class QuizQuestionWidget extends StatefulWidget {
  final String questionNumber;
  final String questionTitle;
  final String points;
  final List<String> options;
  final ValueChanged<int> onOptionSelected;

  const QuizQuestionWidget({
    super.key,
    required this.questionNumber,
    required this.questionTitle,
    required this.points,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  State<QuizQuestionWidget> createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {
  int? selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${widget.questionNumber.toString().padLeft(2, '0')} - ${widget.questionTitle}",
                style: AppTextStyles.s16w500.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
            ),
            Text(
              "${widget.points} Points",
              style: AppTextStyles.s14w400.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Column(
          children: List.generate(widget.options.length, (index) {
            final option = widget.options[index];
            final isSelected = selectedOptionIndex == index;

            return InkWell(
              onTap: () {
                setState(() {
                  selectedOptionIndex = index;
                });
                widget.onOptionSelected(index);
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
