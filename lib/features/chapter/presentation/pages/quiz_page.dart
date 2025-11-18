import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/start_quiz_model.dart';
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
  Map<int, int> selectedOptions = {}; // key: questionIndex, value: choiceIndex

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChapterCubit, ChapterState>(
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state.answerStatus == ResponseStatusEnum.success &&
              state.answer?.message != null &&
              state.answer!.message!.isNotEmpty) {
            AppMessage.showFlushbar(
              context: context,
              message: state.answer!.message!,
              backgroundColor: AppColors.messageInfo,
              title: "Saved",
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
                              selectedOptionIndex: selectedOptions[index] ?? -1,
                              onOptionSelected: (choiceIndex) {
                                setState(() {
                                  selectedOptions[index] = choiceIndex;
                                });

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
                          context.pushReplacement(RouteNames.courses);
                        },
                      ),
                    );
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
// class QuizPage extends StatefulWidget {
//   const QuizPage({super.key});

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   Map<int, int> selectedOptions = {}; // key: questionIndex, value: choiceIndex

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ChapterCubit, ChapterState>(
//       listener: (context, state) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           if (state.answerStatus == ResponseStatusEnum.success &&
//               state.answer?.message != null &&
//               state.answer!.message!.isNotEmpty) {
//             AppMessage.showFlushbar(
//               context: context,
//               message: state.answer!.message!,
//               backgroundColor: AppColors.messageInfo,
//               title: "Saved",
//             );
//           }

//           if (state.answerStatus == ResponseStatusEnum.failure) {
//             AppMessage.showFlushbar(
//               context: context,
//               message: state.answerError!,
//               backgroundColor: AppColors.messageError,
//               isShowProgress: true,
//               title: "Error",
//               iconData: Icons.error_outline,
//               iconColor: AppColors.iconWhite,
//             );
//           }
//         });
//       },
//       builder: (context, state) {
//         final startQuiz = state.statrtQuiz;
//         final quizDetails = state.quizDetails;

//         return Scaffold(
//           backgroundColor: AppColors.backgroundPage,
//           appBar: CustomAppBarWidget(title: "Quiz", showBack: true),
//           body: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 QuizInfoCardWidget(
//                   title: quizDetails?.chapterTitle ?? "Chapter’s Title",
//                   questionCount: quizDetails?.questionsCount ?? 0,
//                   points: quizDetails?.totalPoints ?? 0,
//                   quiz: quizDetails?.title ?? "Quiz Title",
//                 ),
//                 SizedBox(height: 20.h),
//                 if (startQuiz != null)
//                   ...List.generate(startQuiz.questions.length, (index) {
//                     final question = startQuiz.questions[index];
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: 15.h),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           QuizQuestionWidget(
//                             questionNumber: "${index + 1}",
//                             questionTitle: question.questionText,
//                             points: question.points.toString(),
//                             options: question.choices
//                                 .map((choice) => choice.choiceText)
//                                 .toList(),
//                             selectedOptionIndex:
//                                 selectedOptions[index] ?? -1, // ← هنا
//                             onOptionSelected: (choiceIndex) {
//                               // تحديث UI فورًا
//                               setState(() {
//                                 selectedOptions[index] = choiceIndex;
//                               });

//                               // إرسال الريكوست في الخلفية
//                               final selectedChoiceId =
//                                   question.choices[choiceIndex].id;
//                               context.read<ChapterCubit>().submitAnswer(
//                                 quizId: startQuiz.id,
//                                 questionId: question.id,
//                                 selectedChoiceId: selectedChoiceId,
//                               );
//                             },
//                           ),

//                           Divider(height: 1.h, color: AppColors.dividerGrey),
//                         ],
//                       ),
//                     );
//                   }),
//                 SizedBox(height: 20.h),
//                 CustomButtonWidget(
//                   title: "Submit Answers",
//                   titleStyle: AppTextStyles.s16w500.copyWith(
//                     color: AppColors.titlePrimary,
//                   ),
//                   buttonColor: AppColors.buttonPrimary,
//                   borderColor: AppColors.borderPrimary,
//                   onTap: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: false,
//                       backgroundColor: Colors.transparent,
//                       isDismissible: false,
//                       enableDrag: false,
//                       builder: (ctx) => QuizResultBottomSheet(
//                         score: 6,
//                         total: 10,
//                         onDone: () {
//                           Navigator.of(context, rootNavigator: true).pop();
//                           context.pushReplacement(RouteNames.courses);
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class QuizPage extends StatefulWidget {
//   const QuizPage({super.key});

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   late StartQuizModel? startQuiz;
//   late QuizDetailsModel? quizDetails;

//   // خريطة لتخزين الإجابات لكل سؤال
//   Map<int, int> selectedOptions = {}; // key: questionIndex, value: choiceIndex

//   @override
//   void initState() {
//     startQuiz = context.read<ChapterCubit>().state.statrtQuiz;
//     quizDetails = context.read<ChapterCubit>().state.quizDetails;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundPage,
//       appBar: CustomAppBarWidget(title: "Quiz", showBack: true),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             QuizInfoCardWidget(
//               title: quizDetails?.chapterTitle ?? "Chapter’s Title",
//               questionCount: quizDetails?.questionsCount ?? 0,
//               points: quizDetails?.totalPoints ?? 0,
//               quiz: quizDetails?.title ?? "Quiz Title",
//             ),
//             SizedBox(height: 20.h),
//             if (startQuiz != null)
//               ...List.generate(startQuiz!.questions.length, (index) {
//                 final question = startQuiz!.questions[index];
//                 return Padding(
//                   padding: EdgeInsets.only(bottom: 15.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       QuizQuestionWidget(
//                         questionNumber: "${index + 1}",
//                         questionTitle: question.questionText,
//                         points: question.points.toString(),
//                         options: question.choices
//                             .map((choice) => choice.choiceText)
//                             .toList(),
//                         onOptionSelected: (int choiceIndex) async {
//                           // تخزين الاختيار مؤقتًا
//                           selectedOptions[index] = choiceIndex;

//                           final selectedChoiceId =
//                               question.choices[choiceIndex].id;

//                           // إرسال الإجابة عبر Cubit
//                           await context.read<ChapterCubit>().submitAnswer(
//                             quizId: startQuiz!.id,
//                             questionId: question.id,
//                             selectedChoiceId: selectedChoiceId,
//                           );

//                           // الحصول على الرد من الـ state بعد النجاح
//                           final answer = context
//                               .read<ChapterCubit>()
//                               .state
//                               .answer;
//                           if (answer != null) {
//                             // عرض الرسالة لو موجودة
//                             if (answer.message != null &&
//                                 answer.message!.isNotEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text(answer.message!)),
//                               );
//                             }

//                             // تحديث الاختيار على الـ UI بالـ choice الذي أرسلته
//                             setState(() {
//                               selectedOptions[index] = choiceIndex;
//                             });
//                           }
//                         },
//                       ),

//                       Divider(height: 1.h, color: AppColors.dividerGrey),
//                     ],
//                   ),
//                 );
//               }),
//             SizedBox(height: 20.h),
//             CustomButtonWidget(
//               title: "Submit Answers",
//               titleStyle: AppTextStyles.s16w500.copyWith(
//                 color: AppColors.titlePrimary,
//               ),
//               buttonColor: AppColors.buttonPrimary,
//               borderColor: AppColors.borderPrimary,
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: false,
//                   backgroundColor: Colors.transparent,
//                   isDismissible: false,
//                   enableDrag: false,
//                   builder: (ctx) => QuizResultBottomSheet(
//                     score: 6,
//                     total: 10,
//                     onDone: () {
//                       Navigator.of(context, rootNavigator: true).pop();
//                       context.pushReplacement(RouteNames.courses);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _QuizPageState extends State<QuizPage> {
//   late QuizDetailsModel? quizDetails;
//   @override
//   void initState() {
//     quizDetails = context.read<ChapterCubit>().state.quizDetails;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundPage,
//       appBar: CustomAppBarWidget(title: "Quiz", showBack: true),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             QuizInfoCardWidget(
//               title: quizDetails?.chapterTitle ?? "Chapter’s Title",
//               questionCount: quizDetails?.questionsCount ?? 0,
//               points: quizDetails?.totalPoints ?? 0,
//               quiz: quizDetails?.title ?? "Quiz Title",
//             ),
//             SizedBox(height: 20.h),
//             ...List.generate(
//               4,
//               (index) => Padding(
//                 padding: EdgeInsets.only(bottom: 15.h),
//                 child: Column(
//                   children: [
//                     QuizQuestionWidget(
//                       questionNumber: "${index + 1}",
//                       questionTitle: "Question Full Title Question ?",
//                       points: "3",
//                       options: [
//                         "First Answer",
//                         "Second Answer",
//                         "Third Answer",
//                         "Forth Answer",
//                       ],
//                       onOptionSelected: (int value) {
//                         log(value.toString());
//                       },
//                     ),
//                     Divider(height: 1.h, color: AppColors.dividerGrey),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.h),
//             CustomButtonWidget(
//               title: "Submit Answers",
//               titleStyle: AppTextStyles.s16w500.copyWith(
//                 color: AppColors.titlePrimary,
//               ),
//               buttonColor: AppColors.buttonPrimary,
//               borderColor: AppColors.borderPrimary,
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: false,
//                   backgroundColor: Colors.transparent,
//                   isDismissible: false,
//                   enableDrag: false,
//                   builder: (ctx) => QuizResultBottomSheet(
//                     score: 6,
//                     total: 10,
//                     onDone: () {
//                       Navigator.of(context, rootNavigator: true).pop();
//                       context.pushReplacement(RouteNames.courses);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
