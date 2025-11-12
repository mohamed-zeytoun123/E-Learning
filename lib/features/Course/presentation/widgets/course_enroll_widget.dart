import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseEnrollWidget extends StatelessWidget {
  const CourseEnrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 20.h, thickness: 1, color: AppColors.dividerGrey),
        Text(
          "Enroll Now !",
          style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
          textAlign: TextAlign.center,
        ),
        Text(
          "Unlock Full Course For 100,000 S.P",
          style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        CustomButtonWidget(
          onTap: () {
            // context.push(RouteNames.enroll);
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: false,
              builder: (context) => const CourseEnrollBottomSheet(),
            );
          },
          title: "Enroll Now",
          titleStyle: AppTextStyles.s16w500.copyWith(
            color: AppColors.titlePrimary,
          ),
          buttonColor: AppColors.buttonPrimary,
          borderColor: AppColors.borderPrimary,
        ),
      ],
    );
  }
}
