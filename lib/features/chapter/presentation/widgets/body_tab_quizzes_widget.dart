import 'package:e_learning/features/chapter/presentation/widgets/quiz_locked_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/quiz_ready_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabQuizzesWidget extends StatelessWidget {
  const BodyTabQuizzesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h),

      //todo Quizzes Is Locked :
      // child: QuizLockedWidget(remainingVideos: 5),
      child: QuizReadyWidget(questionCount: 4, pointsCount: 1),
    );
  }
}
