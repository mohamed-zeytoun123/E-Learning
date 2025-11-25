import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/app_message.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:e_learning/features/course/presentation/widgets/icon_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class QuizReadyWidget extends StatelessWidget {
  final int questionCount;
  final int pointsCount;

  const QuizReadyWidget({
    super.key,
    required this.questionCount,
    required this.pointsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 88.w,
          height: 88.h,
          decoration: BoxDecoration(
            color: AppColors.backgroundLittelOrange,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Center(
            child: Container(
              width: 48.w,
              height: 48.h,
              color: Colors.black,
            ),
          ),
        ),
        25.sizedH,
        Text(
          'Your Quiz Is Ready !',
          textAlign: TextAlign.center,
          style: AppTextStyles.s18w600.copyWith(color: AppColors.textBlack),
        ),
        6.sizedH,
        Row(
          spacing: 5.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$questionCount Questions',
              style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
            ),
            IconCircleWidget(),
            Text(
              '$pointsCount Points',
              style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
            ),
          ],
        ),
        25.sizedH,
        BlocConsumer<ChapterCubit, ChapterState>(
          listenWhen: (previous, current) =>
              previous.statrtQuizStatus != current.statrtQuizStatus,
          listener: (context, state) {
            if (state.statrtQuizStatus == ResponseStatusEnum.success) {
              context.push(
                RouteNames.quizPage,
                extra: {"chapterCubit": context.read<ChapterCubit>()},
              );
            } else if (state.statrtQuizStatus == ResponseStatusEnum.failure) {
              AppMessage.showError(context, state.statrtQuizError ?? "Something went wrong");
            }
          },
          buildWhen: (previous, current) =>
              previous.statrtQuizStatus != current.statrtQuizStatus,
          builder: (context, state) {
            if (state.statrtQuizStatus == ResponseStatusEnum.loading) {
              return Center(
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: AppLoading.circular(),
                ),
              );
            } else {
              return CustomButton(
                title: "Start Quiz",
                buttonColor: AppColors.buttonPrimary,
                onTap: () {
                  final quizId =
                      context.read<ChapterCubit>().state.quizDetails?.id ?? 0;
                  context.read<ChapterCubit>().startQuiz(quizId: quizId);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
