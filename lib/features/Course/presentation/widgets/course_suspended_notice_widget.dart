import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';

class CourseSuspendedNoticeWidget extends StatelessWidget {
  final VoidCallback onContactPressed;

  const CourseSuspendedNoticeWidget({
    super.key,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 160.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundLittelOrange,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.borderOrange, width: 1.5),
        ),
        child: Column(
          spacing: 12.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Course Has Been Suspended !",
              textAlign: TextAlign.start,
              style: AppTextStyles.s16w600.copyWith(color: AppColors.textBlack),
            ),
            Text(
              "Contact Us To Activate Your Course By The Admin",
              textAlign: TextAlign.start,
              style: AppTextStyles.s14w400.copyWith(color: AppColors.textGrey),
            ),
            CustomButton(
              title: "Contact Us",
            
              buttonColor: AppColors.buttonPrimary,
          
              onTap: onContactPressed,
            ),
          ],
        ),
      ),
    );
  }
}
