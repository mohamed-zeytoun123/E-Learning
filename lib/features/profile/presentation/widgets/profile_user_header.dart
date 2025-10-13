import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/profile/presentation/widgets/user_info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileUserHeader extends StatelessWidget {
  const ProfileUserHeader({super.key});

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
            children: [
              Text('User Name', style: AppTextStyles.s16w600),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Divider(color: AppColors.dividerGrey),
              ),
              Column(
                children: [
                  UserInfoRow(title: 'University', value: 'University Name'),
                  SizedBox(height: 12.h),
                  UserInfoRow(title: 'College', value: 'IUST'),
                  SizedBox(height: 12.h),
                  UserInfoRow(title: 'Year', value: '3rd Year'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
