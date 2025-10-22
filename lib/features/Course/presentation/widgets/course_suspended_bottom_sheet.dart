import 'package:e_learning/core/asset/app_icons.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/course/presentation/widgets/contact_icon_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/contact_options_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseSuspendedBottomSheet extends StatelessWidget {
  const CourseSuspendedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 249.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
            child: Container(
              width: 60.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.dividerGrey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                Text(
                  "Course Has Been Suspended !",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Contact Us To Activate Your Course",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                ),

                SizedBox(height: 25.h),

                ContactOptionsRowWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
