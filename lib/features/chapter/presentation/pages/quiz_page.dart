import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_info_card_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_question_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_result_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      appBar: CustomAppBarWidget(title: "Quiz", showBack: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuizInfoCardWidget(
              title: "Chapter’s Title",
              questionCount: 5,
              points: 10,
            ),
            SizedBox(height: 20.h),
            ...List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Column(
                  children: [
                    QuizQuestionWidget(
                      questionNumber: "${index + 1}",
                      questionTitle: "Question Full Title Question ?",
                      points: "3",
                      options: [
                        "First Answer",
                        "Second Answer",
                        "Third Answer",
                        "Forth Answer",
                      ],
                      onOptionSelected: (int value) {
                        log(value.toString());
                      },
                    ),
                    Divider(height: 1.h, color: AppColors.dividerGrey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButtonWidget(
              title: "Submit Answers",
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.titlePrimary,
              ),
              buttonColor: AppColors.buttonPrimary,
              borderColor: AppColors.borderPrimary,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: false,
                  backgroundColor: Colors.transparent,

                  isDismissible: false,
                  enableDrag: false,

                  builder: (ctx) => QuizResultBottomSheet(
                    score: 6,
                    total: 10,
                    onDone: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      context.pushReplacement(RouteNames.chapterPage);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
