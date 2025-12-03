import 'package:e_learning/core/asset/app_icons.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/Course/presentation/widgets/icon_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizRowWidget extends StatelessWidget {
  final String quizTitle;
  final int questionsCount;
  final int points;
  final VoidCallback? onTap;

  const QuizRowWidget({
    super.key,
    required this.quizTitle,
    required this.questionsCount,
    this.points = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.grey.withOpacity(0.2),
            highlightColor: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              height: 88.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // الدائرة الزرقاء مع أيقونة قلم
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.formSecondary,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(AppIcons.iconQuizze),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quizTitle,
                          style: AppTextStyles.s16w600.copyWith(
                            color: AppColors.textBlack,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          spacing: 10.w,
                          children: [
                            Text(
                              "$questionsCount Questions",
                              style: AppTextStyles.s14w400.copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),

                            IconCircleWidget(),

                            Text(
                              "$points Points",
                              style: AppTextStyles.s14w400.copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: AppColors.iconBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(height: 1.h, color: AppColors.dividerGrey),
      ],
    );
  }
}
