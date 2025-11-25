import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizLockedWidget extends StatelessWidget {
  // final int remainingVideos;

  const QuizLockedWidget({
    super.key,
    //  required this.remainingVideos
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 88.w,
          height: 88.h,
          child: CircleAvatar(
            radius: 44.r,
            backgroundColor: AppColors.backgroundLittelOrange,
            child: Container(
              width: 48.w,
              height: 48.h,
              color: Colors.black,
            ),
          ),
        ),
        20.sizedH,
        Text(
          context.read<ChapterCubit>().state.quizDetailsError ??
              'No quiz available !',
          textAlign: TextAlign.center,
          style: AppTextStyles.s18w600.copyWith(color: AppColors.textBlack),
        ),
        // 6.sizedH,
        // Text(
        //   "You Have $remainingVideos Videos Left to Unlock Your Quiz",
        //   style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
        // ),
      ],
    );
  }
}
