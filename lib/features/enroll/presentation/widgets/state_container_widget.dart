import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StateContainerWidget extends StatelessWidget {
  final CourseStateEnum courseState;
  const StateContainerWidget({super.key, required this.courseState});

  Color _getContainerColor(BuildContext context) {
    switch (courseState) {
      case CourseStateEnum.active:
        return context.colors.textBlue;
      case CourseStateEnum.completed:
        return AppColors.formCompleted.withOpacity(0.08);
      case CourseStateEnum.suspended:
        return const Color.fromARGB(24, 244, 112, 68);
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (courseState) {
      case CourseStateEnum.active:
        return AppColors.appBarWhite;
      case CourseStateEnum.completed:
        return AppColors.textGreen;
      case CourseStateEnum.suspended:
        return AppColors.textOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: _getContainerColor(context),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        courseState.name,
        style: AppTextStyles.s12w400.copyWith(color: _getTextColor(context)),
      ),
    );
  }
}
