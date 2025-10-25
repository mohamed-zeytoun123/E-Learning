import 'package:e_learning/core/asset/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class QuizLockedWidget extends StatelessWidget {
  final int remainingVideos;

  const QuizLockedWidget({super.key, required this.remainingVideos});

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
            child: Image.asset(AppIcons.iconErrorOutline),
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'Your Quiz Is Not Ready Yet !',
          textAlign: TextAlign.center,
          style: AppTextStyles.s18w600.copyWith(color: AppColors.textBlack),
        ),
        SizedBox(height: 6.h),
        Text(
          "You Have $remainingVideos Videos Left to Unlock Your Quiz",
          style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
        ),
      ],
    );
  }
}
