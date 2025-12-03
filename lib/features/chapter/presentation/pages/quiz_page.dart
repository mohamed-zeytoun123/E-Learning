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
  const QuizPage({super.key, this.quizId});

  final int? quizId;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();

    // If we have a quiz ID, start the quiz
    if (widget.quizId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ChapterCubit>().startQuiz(quizId: widget.quizId!);
      });
    }
  }

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
          pre.selectedOptions != curr.selectedOptions ||
          pre.statrtQuizStatus != curr.statrtQuizStatus,

      builder: (context, state) {
        // Handle loading state for starting quiz
        if (state.statrtQuizStatus == ResponseStatusEnum.loading) {
          return WillPopScope(
            onWillPop: () async => false, // يمنع الخروج
            child: Scaffold(
              backgroundColor: AppColors.backgroundPage,
              appBar: CustomAppBarWidget(title: "Quiz", showBack: false),
              body: Center(child: AppLoading.circular()),
            ),
          );
        }

        // Handle error state for starting quiz
        // Handle error state for starting quiz
        // Handle error state for starting quiz
        if (state.statrtQuizStatus == ResponseStatusEnum.failure) {
          final errorMessage = state.statrtQuizError ?? "Failed to load quiz";
          final containsAlready = errorMessage.toLowerCase().contains(
            "already",
          );

          return WillPopScope(
            onWillPop: () async =>
                !containsAlready, // يسمح بالخروج فقط لو فيها already
            child: Scaffold(
              backgroundColor: AppColors.backgroundPage,
              appBar: CustomAppBarWidget(
                title: "Quiz",
                showBack: containsAlready, // زر العودة يظهر فقط لو فيها already
              ),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        containsAlready
                            ? Icons
                                  .sentiment_dissatisfied_outlined // وجه عابس
                            : Icons.error_outline,
                        size: 50.sp,
                        color: containsAlready
                            ? AppColors.textGrey
                            : AppColors.iconError,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.s16w400.copyWith(
                          color: containsAlready
                              ? AppColors.textGrey
                              : AppColors.textError,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomButtonWidget(
                        title: containsAlready ? "Back" : "Retry",
                        titleStyle: AppTextStyles.s16w500.copyWith(
                          color: containsAlready
                              ? AppColors.titlePrimary
                              : AppColors.textWhite,
                        ),
                        buttonColor: AppColors.buttonPrimary,
                        borderColor: AppColors.borderPrimary,
                        onTap: () {
                          if (containsAlready) {
                            context.pop();
                          } else {
                            if (widget.quizId != null) {
                              context.read<ChapterCubit>().startQuiz(
                                quizId: widget.quizId!,
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        // if (state.statrtQuizStatus == ResponseStatusEnum.failure) {
        //   return WillPopScope(
        //     onWillPop: () async => false,
        //     child: Scaffold(
        //       backgroundColor: AppColors.backgroundPage,
        //       appBar: CustomAppBarWidget(title: "Quiz", showBack: false),
        //       body: Center(
        //         child: Padding(
        //           padding: EdgeInsets.all(20.w),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Icon(
        //                 Icons.error_outline,
        //                 size: 50.sp,
        //                 color: AppColors.iconError,
        //               ),
        //               SizedBox(height: 16.h),
        //               Text(
        //                 state.statrtQuizError ?? "Failed to load quiz",
        //                 textAlign: TextAlign.center,
        //                 style: AppTextStyles.s16w400.copyWith(
        //                   color: AppColors.textError,
        //                 ),
        //               ),
        //               SizedBox(height: 20.h),
        //               CustomButtonWidget(
        //                 title: "Retry",
        //                 titleStyle: AppTextStyles.s16w500.copyWith(
        //                   color: AppColors.titlePrimary,
        //                 ),
        //                 buttonColor: AppColors.buttonPrimary,
        //                 borderColor: AppColors.borderPrimary,
        //                 onTap: () {
        //                   if (widget.quizId != null) {
        //                     context.read<ChapterCubit>().startQuiz(
        //                       quizId: widget.quizId!,
        //                     );
        //                   }
        //                 },
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   );
        // }

        final startQuiz = state.statrtQuiz;
        final quizDetails = startQuiz != null ? null : state.quizDetails;

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: AppColors.backgroundPage,
            appBar: CustomAppBarWidget(title: "Quiz", showBack: false),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuizInfoCardWidget(
                    title:
                        startQuiz?.quizTitle ??
                        quizDetails?.chapterTitle ??
                        "Chapter's Title",
                    questionCount:
                        startQuiz?.questions.length ??
                        quizDetails?.questionsCount ??
                        0,
                    points:
                        startQuiz?.totalPoints ?? quizDetails?.totalPoints ?? 0,
                    quiz:
                        startQuiz?.quizTitle ??
                        quizDetails?.title ??
                        "Quiz Title",
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
                              Divider(
                                height: 1.h,
                                color: AppColors.dividerGrey,
                              ),
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

                                  context
                                      .read<ChapterCubit>()
                                      .submitAnswersList(
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
          ),
        );
      },
    );
  }
}
