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
      listenWhen: (pre, curr) => pre.answerStatus != curr.answerStatus,
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state.answerStatus == ResponseStatusEnum.success &&
              state.answer?.message != null) {
            AppMessage.showFlushbar(
              context: context,
              message: state.answer!.message!,
              backgroundColor: AppColors.messageInfo,
              title: "Saved",
              isShowProgress: true,
            );
          }

          if (state.answerStatus == ResponseStatusEnum.failure) {
            AppMessage.showFlushbar(
              context: context,
              message: state.answerError!,
              backgroundColor: AppColors.messageError,
              isShowProgress: true,
              title: "Error",
              iconData: Icons.error_outline,
              iconColor: AppColors.iconWhite,
            );
          }
        });
      },

      buildWhen: (pre, curr) => pre.answerStatus != curr.answerStatus,

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

                                if (question.choices.isNotEmpty) {
                                  final selectedChoiceId =
                                      question.choices[choiceIndex].id;
                                  context.read<ChapterCubit>().submitAnswer(
                                    quizId: startQuiz.id,
                                    questionId: question.id,
                                    selectedChoiceId: selectedChoiceId,
                                  );
                                }
                              },
                            ),
                            Divider(height: 1.h, color: AppColors.dividerGrey),
                          ],
                        ),
                      );
                    },
                  ),
                SizedBox(height: 20.h),
                BlocBuilder<ChapterCubit, ChapterState>(
                  builder: (context, state) {
                    switch (state.submitStatus) {
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
                              state.submitError ?? "Unknown error",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.s16w400.copyWith(
                                color: AppColors.textError,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            CustomButtonWidget(
                              title: "Retry",
                              titleStyle: AppTextStyles.s16w500.copyWith(
                                color: AppColors.textWhite,
                              ),
                              buttonColor: AppColors.buttonPrimary,
                              borderColor: AppColors.borderPrimary,
                              onTap: () {
                                context
                                    .read<ChapterCubit>()
                                    .submitCompletedQuiz(
                                      attemptId: state.submit?.attempt?.id ?? 0,
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
                            context.read<ChapterCubit>().submitCompletedQuiz(
                              attemptId: state.submit?.attempt?.id ?? 0,
                            );
                          },
                        );

                      case ResponseStatusEnum.success:
                        final result = state.submit;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: false,
                            isDismissible: false,
                            enableDrag: false,
                            builder: (ctx) => WillPopScope(
                              onWillPop: () async => false,
                              child: QuizResultBottomSheet(
                                score: result?.attempt?.score ?? "0.0",
                                total: result?.attempt?.totalPoints ?? 0,
                                isPassed: result?.attempt?.isPassed ?? false,
                                onDone: () {
                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pop();
                                  context.pushReplacement(RouteNames.courses);
                                },
                              ),
                            ),
                          );
                        });
                        return SizedBox.shrink();
                      case null:
                        throw UnimplementedError();
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
