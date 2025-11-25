import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/asset/app_icons.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizResultBottomSheet extends StatelessWidget {
  final String score;
  final int total;
  final VoidCallback? onDone;
  final bool isPassed;

  const QuizResultBottomSheet({
    super.key,
    required this.score,
    required this.total,
    this.onDone,
    required this.isPassed,
  });

  @override
  Widget build(BuildContext context) {
    final Widget icon = isPassed
        ? Image(image: AssetImage(AppIcons.iconCheckDouble))
        : Image(image: AssetImage(AppIcons.iconErrorOutline));

    final Color backgroundColor =
        isPassed ? AppColors.secondary : AppColors.backgroundLittelOrange;

    final String title =
        isPassed ? 'Congratulations !' : 'Sorry, You Didn’t Pass The Quiz';

    final String subtitle = isPassed
        ? 'You Have Passed The Quiz'
        : 'You Can Try Again When you’re Ready';

    return Container(
      height: 344.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: AppColors.dividerWhite,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          25.sizedH,
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(child: icon),
          ),
          25.sizedH,
          Text(
            '$score/$total Points',
            style: AppTextStyles.s16w400.copyWith(color: AppColors.textGrey),
          ),
          25.sizedH,
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.s16w400.copyWith(color: AppColors.textGrey),
          ),
          20.sizedH,
          CustomButton(
            title: 'Done',
            buttonColor: AppColors.buttonPrimary,
            onTap: onDone,
          ),
        ],
      ),
    );
  }
}
