import 'package:e_learning/core/asset/app_icons.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/icon_circle_widget.dart';
import 'package:flutter/material.dart';
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
    final colors =context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 88.w,
          height: 88.h,
          decoration: BoxDecoration(
            color: colors.buttonTapNotSelected,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Center(
            child: Image.asset(
              AppIcons.iconQuizzeReady,
              width: 48.w,
              height: 48.h,
              color: colors.textBlue,
              fit: BoxFit.contain,
            ),
          ),
        ),

        SizedBox(height: 25.h),

        Text(
          'Your Quiz Is Ready !',
          textAlign: TextAlign.center,
          style: AppTextStyles.s18w600.copyWith(color: colors.textPrimary),
        ),

        SizedBox(height: 6.h),

        Row(
          spacing: 5.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$questionCount Questions',
              style: AppTextStyles.s14w400.copyWith(color: colors.textGrey),
            ),
            IconCircleWidget(),
            Text(
              '$pointsCount Points',
              style: AppTextStyles.s14w400.copyWith(color: colors.textGrey),
            ),
          ],
        ),

        SizedBox(height: 25.h),

        CustomButtonWidget(
          title: "Start Quiz",
          titleStyle: AppTextStyles.s16w500.copyWith(
            color: AppColors.titlePrimary,
          ),
          buttonColor: colors.textBlue,
          borderColor: colors.textBlue,
          icon: Icon(Icons.arrow_outward_sharp, color: AppColors.iconWhite),
          onTap: () {
            context.push(RouteNames.quizPage);
          },
        ),
      ],
    );
  }
}
