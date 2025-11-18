import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_details_model.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_locked_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_ready_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabQuizzesWidget extends StatefulWidget {
  const BodyTabQuizzesWidget({super.key, required this.chapterId});
  final int chapterId;
  @override
  State<BodyTabQuizzesWidget> createState() => _BodyTabQuizzesWidgetState();
}

class _BodyTabQuizzesWidgetState extends State<BodyTabQuizzesWidget> {
  @override
  void initState() {
    context.read<ChapterCubit>().getQuizDetails(chapterId: widget.chapterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChapterCubit, ChapterState>(
      builder: (context, state) {
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
                  child: const QuizLockedWidget(
                    // remainingVideos: 5
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
                  child: Center(
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
                              'An error occurred while loading the quizzes 😕',
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
              ),
            );
          }
        }

        if (state.quizDetailsStatus == ResponseStatusEnum.success &&
            state.quizDetails != null) {
          final QuizDetailsModel quiz = state.quizDetails!;
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: QuizReadyWidget(
                questionCount: quiz.questionsCount,
                pointsCount: quiz.totalPoints,
              ),
            ),
          );
        }

        // الحالة الافتراضية
        return const SizedBox.shrink();
      },
    );
  }
}
