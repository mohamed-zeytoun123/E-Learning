import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/features/course/presentation/widgets/course_suspended_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseSuspendedWidget extends StatelessWidget {
  const CourseSuspendedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 20.h, thickness: 1, color: AppColors.dividerGrey),
        Text(
          "Course Has Been Suspended !",
          style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
          textAlign: TextAlign.center,
        ),
        Text(
          "Contact Us To Activate Your Course",
          style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 20.h),
        CustomButton(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: false,
              builder: (context) => const CourseSuspendedBottomSheet(),
            );
          },
          title: "Contact Us",
         
          buttonColor: AppColors.buttonPrimary,
         
        ),
      ],
    );
  }
}
