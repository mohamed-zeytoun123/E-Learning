import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopHomeSection extends StatelessWidget {
  const TopHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
              elevation: 6,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 24.h,
                  horizontal: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'start_learning'.tr(),
                      style: AppTextStyles.s14w500
                          .copyWith(color: AppColors.textGrey),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'browse_courses'.tr(),
                      style: AppTextStyles.s18w600,
                    ),
                  ],
                ),
              ),
            );
  }
}