import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_info_card_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_question_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_result_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChapterCubit, ChapterState>(
      listenWhen: (pre, curr) =>
          pre.submitAnswersListStatus != curr.submitAnswersListStatus,
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state.submitAnswersListStatus == ResponseStatusEnum.success &&
              state.submitAnswersList?.message != null) {
            AppMessage.showFlushbar(
              context: context,
              message: state.submitAnswersList!.message!,
              backgroundColor: AppColors.messageInfo,
              title: "Saved",
              isShowProgress: true,
            );
          }

          if (state.submitAnswersListStatus == ResponseStatusEnum.failure) {
            AppMessage.showFlushbar(
              context: context,
              message: state.submitAnswersListError ?? "Unknown error",
              backgroundColor: AppColors.messageError,
              isShowProgress: true,
              title: "Error",
              iconData: Icons.error_outline,
              iconColor: AppColors.iconWhite,
            );
          }
        });
      },

      buildWhen: (pre, curr) =>
          pre.submitAnswersListStatus != curr.submitAnswersListStatus ||
          pre.selectedOptions != curr.selectedOptions,

      builder: (context, state) {
        final startQuiz = state.statrtQuiz;
        final quizDetails = state.quizDetails;

        return Scaffold(
          backgroundColor: AppColors.backgroundPage,
          appBar: CustomAppBarWidget(title: "Quiz", showBack: true),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                QuizInfoCardWidget(
                  title: quizDetails?.chapterTitle ?? "Chapter’s Title",
                  questionCount: quizDetails?.questionsCount ?? 0,
                  points: quizDetails?.totalPoints ?? 0,
                  quiz: quizDetails?.title ?? "Quiz Title",
                ),
                SizedBox(height: 20.h),

                /// Questions List
                if (startQuiz != null)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: startQuiz.questions.length,
                    itemBuilder: (context, index) {
                      final question = startQuiz.questions[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            QuizQuestionWidget(
                              key: ValueKey(question.id),
                              questionNumber: "${index + 1}",
                              questionTitle: question.questionText,
                              points: question.points.toString(),
                              options: question.choices
                                  .map((c) => c.choiceText)
                                  .toList(),
                              selectedOptionIndex:
                                  state.selectedOptions[index] ?? -1,

                              onOptionSelected: (choiceIndex) {
                                context.read<ChapterCubit>().selectAnswer(
                                  questionIndex: index,
                                  choiceIndex: choiceIndex,
                                );
                              },
                            ),
                            Divider(height: 1.h, color: AppColors.dividerGrey),
                          ],
                        ),
                      );
                    },
                  ),

                SizedBox(height: 20.h),

                /// Submit Button System
                BlocBuilder<ChapterCubit, ChapterState>(
                  buildWhen: (previous, current) =>
                      previous.submitAnswersListStatus !=
                      current.submitAnswersListStatus,
                  builder: (context, state) {
                    switch (state.submitAnswersListStatus) {
                      case ResponseStatusEnum.loading:
                        return Center(child: AppLoading.circular());

                      case ResponseStatusEnum.failure:
                        return Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 40.sp,
                              color: AppColors.iconError,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              state.submitAnswersListError ?? "Unknown error",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.s16w400.copyWith(
                                color: AppColors.textError,
                              ),
                            ),
                            SizedBox(height: 15.h),

                            /// Retry Button
                            CustomButtonWidget(
                              title: "Retry",
                              titleStyle: AppTextStyles.s16w500.copyWith(
                                color: AppColors.textWhite,
                              ),
                              buttonColor: AppColors.buttonPrimary,
                              borderColor: AppColors.borderPrimary,
                              onTap: () {
                                final questions = startQuiz?.questions ?? [];
                                final selected = context
                                    .read<ChapterCubit>()
                                    .state
                                    .selectedOptions;

                                final answersList = <Map<String, dynamic>>[];

                                for (int i = 0; i < questions.length; i++) {
                                  final q = questions[i];
                                  final selectedIndex = selected[i];

                                  if (selectedIndex != null &&
                                      selectedIndex >= 0) {
                                    answersList.add({
                                      "question_id": q.id,
                                      "selected_choice_id":
                                          q.choices[selectedIndex].id,
                                    });
                                  }
                                }

                                context.read<ChapterCubit>().submitAnswersList(
                                  attemptId: startQuiz?.id ?? 0,
                                  answers: answersList,
                                );
                              },
                            ),
                          ],
                        );

                      case ResponseStatusEnum.initial:
                        return CustomButtonWidget(
                          title: "Submit Answers",
                          titleStyle: AppTextStyles.s16w500.copyWith(
                            color: AppColors.titlePrimary,
                          ),
                          buttonColor: AppColors.buttonPrimary,
                          borderColor: AppColors.borderPrimary,
                          onTap: () {
                            final questions = startQuiz?.questions ?? [];
                            final selected = context
                                .read<ChapterCubit>()
                                .state
                                .selectedOptions;

                            final answersList = <Map<String, dynamic>>[];

                            for (int i = 0; i < questions.length; i++) {
                              final q = questions[i];
                              final selectedIndex = selected[i];

                              if (selectedIndex != null && selectedIndex >= 0) {
                                answersList.add({
                                  "question_id": q.id,
                                  "selected_choice_id":
                                      q.choices[selectedIndex].id,
                                });
                              }
                            }

                            context.read<ChapterCubit>().submitAnswersList(
                              attemptId: startQuiz?.id ?? 0,
                              answers: answersList,
                            );
                          },
                        );

                      case ResponseStatusEnum.success:
                        final result = state.submitAnswersList;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: false,
                            isDismissible: false,
                            enableDrag: false,
                            builder: (ctx) => PopScope(
                              canPop: false,
                              child: QuizResultBottomSheet(
                                score: result?.attempt?.score ?? "0.0",
                                total: result?.attempt?.totalPoints ?? 0,
                                isPassed: result?.attempt?.isPassed ?? false,
                                onDone: () {
                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pop();
                                  context.go(RouteNames.courses);
                                },
                              ),
                            ),
                          );
                        });
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}