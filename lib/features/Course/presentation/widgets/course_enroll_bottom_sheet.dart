import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/features/Course/presentation/widgets/contact_options_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CourseEnrollBottomSheet extends StatelessWidget {
  const CourseEnrollBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.h,
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h, top: 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 80.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColors.dividerWhite,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          25.sizedH,
          Text(
            "Get Your Enrollment Code !",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textBlack,
            ),
          ),
          8.sizedH,
          Text(
            "Contact Us To Receive Payment Information & Enroll In This Course",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textGrey,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: ContactOptionsRowWidget(),
          ),
          Divider(
            height: 30.h,
            thickness: 1,
            color: AppColors.dividerGrey.withOpacity(0.5),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Or Pay Directly Via",
                  style: AppTextStyles.s16w600.copyWith(
                    color: AppColors.textBlack,
                  ),
                ),
                InkWell(
                  onTap: () {
                    //todo action
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 20.h),
                    child: Row(
                      spacing: 5.w,
                      children: [
                        Container(
                          width: 42.w,
                          height: 48.h,
                          color: Colors.black,
                        ),
                        8.sizedW,
                        Text(
                          "Sham Cash",
                          style: AppTextStyles.s16w400.copyWith(
                            color: AppColors.textBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.sizedH,
          Center(
            child: CustomButton(
              onTap: () {
                context.pop();
              },
              title: "Cancel",
              buttonColor: AppColors.buttonPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
