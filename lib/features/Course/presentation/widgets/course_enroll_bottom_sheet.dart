import 'package:e_learning/core/asset/app_icons.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/course/presentation/widgets/contact_options_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseEnrollBottomSheet extends StatelessWidget {
  const CourseEnrollBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
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
          SizedBox(height: 25.h),
          Text(
            "Get Your Enrollment Code !",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 8.h),
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
                        Image.asset(
                          AppIcons.iconShamCach,
                          width: 42.w,
                          height: 48.h,
                        ),
                        SizedBox(width: 8.w),
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
        ],
      ),
    );
  }
}
