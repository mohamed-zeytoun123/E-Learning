import 'package:e_learning/features/chapter/data/models/quiz_model.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_locked_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_ready_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabQuizzesWidget extends StatelessWidget {
  const BodyTabQuizzesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChapterCubit, ChapterState, List<QuizModel>?>(
      selector: (state) => state.chapter?.quizzes,
      builder: (context, quizzes) {
        if (quizzes == null) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 50,
                    color: Colors.redAccent,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'An error occurred while loading the quizzes 😕\nPlease try again later.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          );
        }

        if (quizzes.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: const QuizLockedWidget(remainingVideos: 5),
            ),
          );
        }

        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: QuizReadyWidget(
              questionCount: quizzes.length,
              pointsCount: quizzes.length * 2,
            ),
          ),
        );
      },
    );
  }
}
