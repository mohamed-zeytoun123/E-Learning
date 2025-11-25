import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/features/Course/presentation/widgets/contact_options_row_widget.dart';
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
                10.sizedH,

                Text(
                  "Course Has Been Suspended !",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textBlack,
                  ),
                ),
                8.sizedH,
                Text(
                  "Contact Us To Activate Your Course",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                ),

                25.sizedH,

                ContactOptionsRowWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
