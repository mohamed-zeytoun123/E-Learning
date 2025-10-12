import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileGuestHeader extends StatelessWidget {
  const ProfileGuestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 198.h,
      width: 362.w,
      child: Card(
        color: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle_outlined,
                size: 48.sp,
                color: AppColors.iconGrey,
              ),
              SizedBox(height: 16.h),
              Text(
                'Please log in to view your profile',
                style: AppTextStyles.s16w600.copyWith(
                  color: AppColors.textGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
