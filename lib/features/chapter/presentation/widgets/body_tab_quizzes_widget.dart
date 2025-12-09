import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_list_model.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_locked_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_ready_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:go_router/go_router.dart';

class BodyTabQuizzesWidget extends StatefulWidget {
  const BodyTabQuizzesWidget({super.key, required this.chapterId});
  final int chapterId;

  @override
  State<BodyTabQuizzesWidget> createState() => _BodyTabQuizzesWidgetState();
}

class _BodyTabQuizzesWidgetState extends State<BodyTabQuizzesWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ChapterCubit>().getQuizDetails(chapterId: widget.chapterId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChapterCubit, ChapterState>(
      buildWhen: (previous, current) =>
          previous.quizDetailsStatus != current.quizDetailsStatus ||
          previous.quizDetails != current.quizDetails ||
          previous.quizList != current.quizList,
      builder: (context, state) {
        // Loading state
        if (state.quizDetailsStatus == ResponseStatusEnum.loading) {
          return Center(child: AppLoading.circular());
        }

        if (state.quizDetailsStatus == ResponseStatusEnum.failure) {
          if (state.quizDetailsError != null &&
              state.quizDetailsError!.toLowerCase().contains('quiz')) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.quiz_outlined,
                        size: 50.sp,
                        color: AppColors.textGrey.withOpacity(0.5),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "No quizzes available",
                        style: AppTextStyles.s16w600.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "This chapter does not contain any quizzes",
                        style: AppTextStyles.s14w400.copyWith(
                          color: AppColors.textGrey.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40.h,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 50,
                        color: AppColors.iconError,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        state.quizDetailsError ??
                            'An error occurred while loading the quizzes.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.textGrey,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomButtonWidget(
                        onTap: () {
                          context.read<ChapterCubit>().getQuizDetails(
                            chapterId: widget.chapterId,
                          );
                        },
                        title: "Retry",
                        titleStyle: AppTextStyles.s16w500.copyWith(
                          color: AppColors.titlePrimary,
                        ),
                        buttonColor: AppColors.buttonPrimary,
                        borderColor: AppColors.borderPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }

        // Success state
        if (state.quizDetailsStatus == ResponseStatusEnum.success) {
          // Quiz list
          if (state.quizList != null) {
            final QuizListModel quizList = state.quizList!;

            if (quizList.quizzes.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.quiz_outlined,
                          size: 50.sp,
                          color: AppColors.textGrey.withOpacity(0.5),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "No quizzes available",
                          style: AppTextStyles.s16w600.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "This chapter does not contain any quizzes",
                          style: AppTextStyles.s14w400.copyWith(
                            color: AppColors.textGrey.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
              child: ListView.builder(
                itemCount: quizList.quizzes.length,
                itemBuilder: (context, index) {
                  final QuizDetailsModel quiz = quizList.quizzes[index];
                  return QuizRowWidget(
                    quizTitle: quiz.title,
                    questionsCount: quiz.questionsCount,
                    points: quiz.totalPoints,
                    onTap: () {
                      context.pushNamed(
                        RouteNames.quizPage,
                        extra: {
                          'quizId': quiz.id,
                          'chapterCubit': context.read<ChapterCubit>(),
                        },
                      );
                    },
                  );
                },
              ),
            );
          }
          // Fallback to single quiz
          // else if (state.quizDetails != null) {
          //   final QuizDetailsModel quiz = state.quizDetails!;
          //   return Center(
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 30.h),
          //       child: QuizReadyWidget(
          //         questionCount: quiz.questionsCount,
          //         pointsCount: quiz.totalPoints,
          //       ),
          //     ),
          //   );
          // }
        }

        // Default
        return const SizedBox.shrink();
      },
    );
  }
}

// import 'package:e_learning/core/colors/app_colors.dart';
// import 'package:e_learning/core/style/app_text_styles.dart';
// import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
// import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
// import 'package:e_learning/core/widgets/loading/app_loading.dart';
// import 'package:e_learning/features/chapter/data/models/quize/quiz_model/quiz_details_model.dart';
// import 'package:e_learning/features/chapter/data/models/quize/quiz_list_model.dart';
// import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
// import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
// import 'package:e_learning/features/chapter/presentation/widgets/quiz_locked_widget.dart';
// import 'package:e_learning/features/chapter/presentation/widgets/quiz_ready_widget.dart';
// import 'package:e_learning/features/chapter/presentation/widgets/quiz_row_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:e_learning/core/router/route_names.dart';
// import 'package:go_router/go_router.dart';

// class BodyTabQuizzesWidget extends StatefulWidget {
//   const BodyTabQuizzesWidget({super.key, required this.chapterId});
//   final int chapterId;
//   @override
//   State<BodyTabQuizzesWidget> createState() => _BodyTabQuizzesWidgetState();
// }

// class _BodyTabQuizzesWidgetState extends State<BodyTabQuizzesWidget> {
//   @override
//   void initState() {
//     context.read<ChapterCubit>().getQuizDetails(chapterId: widget.chapterId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ChapterCubit, ChapterState>(
//       buildWhen: (previous, current) =>
//           previous.quizDetailsStatus != current.quizDetailsStatus ||
//           previous.quizDetails != current.quizDetails ||
//           previous.quizList != current.quizList,
//       builder: (context, state) {
//         if (state.quizDetailsStatus == ResponseStatusEnum.loading) {
//           return Center(child: AppLoading.circular());
//         }

//         if (state.quizDetailsStatus == ResponseStatusEnum.failure) {
//           if (state.quizDetailsError != null &&
//               state.quizDetailsError!.toLowerCase().contains('quiz')) {
//             return Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 30.h),
//                   child: const QuizLockedWidget(
//                     // remainingVideos: 5
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 40.h,
//                     horizontal: 20.w,
//                   ),
//                   child: Center(
//                     child: Column(
//                       children: [
//                         const Icon(
//                           Icons.error_outline,
//                           size: 50,
//                           color: AppColors.iconError,
//                         ),
//                         SizedBox(height: 16.h),
//                         Text(
//                           state.quizDetailsError ??
//                               'An error occurred while loading the quizzes 😕',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: AppColors.textGrey,
//                           ),
//                         ),
//                         SizedBox(height: 10.h),
//                         CustomButtonWidget(
//                           onTap: () {
//                             context.read<ChapterCubit>().getQuizDetails(
//                               chapterId: widget.chapterId,
//                             );
//                           },
//                           title: "Retry",
//                           titleStyle: AppTextStyles.s16w500.copyWith(
//                             color: AppColors.titlePrimary,
//                           ),
//                           buttonColor: AppColors.buttonPrimary,
//                           borderColor: AppColors.borderPrimary,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }
//         }

//         // Handle success state with quiz list or single quiz
//         if (state.quizDetailsStatus == ResponseStatusEnum.success) {
//           // First check if we have a quiz list (new approach)
//           if (state.quizList != null) {
//             final QuizListModel quizList = state.quizList!;

//             if (quizList.quizzes.isEmpty) {
//               return Center(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: 30.h),
//                     child: const QuizLockedWidget(),
//                   ),
//                 ),
//               );
//             }

//             // If there's only one quiz, show the ready widget
//             if (quizList.quizzes.isNotEmpty) {
//               final quiquizList = quizList.quizzes;
//               // return QuizRowWidget(
//               //   quizTitle: quiz.title,
//               //   questionsCount: quiz.questionsCount,
//               //   onTap: ,
//               // );
//               //               return Padding(
//               //     padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
//               //     child: ListView.builder(
//               //       shrinkWrap: true,
//               //       physics: const NeverScrollableScrollPhysics(),
//               //       itemCount: quizList.quizzes.length,
//               //       itemBuilder: (context, index) {
//               //         final QuizDetailsModel quiz = quizList.quizzes[index];
//               //         return QuizCardWidget(
//               //           quiz: quiz,
//               //           onTap: () {
//               //             // Navigate to quiz page with quiz ID
//               //             context.pushNamed(
//               //               RouteNames.quizPage,
//               //               extra: {'quizId': quiz.id},
//               //             );
//               //           },
//               //         );
//               //       },
//               //     ),
//               //   );
//               // }
//               //             // return Center(
//               //   child: Padding(
//               //     padding: EdgeInsets.symmetric(vertical: 30.h),
//               //     child: QuizReadyWidget(
//               //       questionCount: quiz.questionsCount,
//               //       pointsCount: quiz.totalPoints,
//               //     ),
//               //   ),
//               // );
//             }

//             // If there are multiple quizzes, show them as a list
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
//               child: ListView.builder(
//                 itemCount: quizList.quizzes.length,
//                 itemBuilder: (context, index) {
//                   final QuizDetailsModel quiz = quizList.quizzes[index];
//                   return QuizCardWidget(
//                     quiz: quiz,
//                     onTap: () {
//                       // Navigate to quiz page with quiz ID and chapter cubit
//                       context.pushNamed(
//                         RouteNames.quizPage,
//                         extra: {
//                           'quizId': quiz.id,
//                           'chapterCubit': context.read<ChapterCubit>(),
//                         },
//                       );
//                     },
//                   );
//                 },
//               ),
//             );
//           }
//           // Fallback to single quiz model (old approach)
//           else if (state.quizDetails != null) {
//             final QuizDetailsModel quiz = state.quizDetails!;
//             return Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 30.h),
//                 child: QuizReadyWidget(
//                   questionCount: quiz.questionsCount,
//                   pointsCount: quiz.totalPoints,
//                 ),
//               ),
//             );
//           }
//         }

//         // Default state
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }

class QuizCardWidget extends StatelessWidget {
  final QuizDetailsModel quiz;
  final VoidCallback onTap;

  const QuizCardWidget({super.key, required this.quiz, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      elevation: 3,
      child: InkWell(
        onTap: () {
          // Navigate to quiz page with quiz ID
          context.pushNamed(RouteNames.quizPage, extra: {'quizId': quiz.id});
        },
        borderRadius: BorderRadius.circular(15.r),
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quiz.title,
                style: AppTextStyles.s18w600.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                quiz.description.isNotEmpty
                    ? quiz.description
                    : "No description",
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Icons.question_answer_outlined,
                    size: 16.sp,
                    color: AppColors.textGrey,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${quiz.questionsCount} Questions",
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Icon(
                    Icons.star_border_outlined,
                    size: 16.sp,
                    color: AppColors.textGrey,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "${quiz.totalPoints} Points",
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              if (quiz.hasAttempted)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    "Attempted",
                    style: AppTextStyles.s14w500.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
