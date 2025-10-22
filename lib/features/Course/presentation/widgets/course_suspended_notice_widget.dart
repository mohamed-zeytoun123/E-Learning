import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

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
            CustomButtonWidget(
              title: "Contact Us",
              titleStyle: AppTextStyles.s16w500.copyWith(
                color: AppColors.textWhite,
              ),
              buttonColor: AppColors.buttonPrimary,
              borderColor: AppColors.borderPrimary,
              onTap: onContactPressed,
            ),
          ],
        ),
      ),
    );
  }
}
