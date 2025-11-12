import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/profile/presentation/widgets/user_info_row.dart';
import 'package:easy_localization/easy_localization.dart';
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
        color: AppColors.backgroundPage,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          child: Column(
            children: [
              Text(
                'user_name'.tr(),
                style: AppTextStyles.s16w600.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Divider(color: AppColors.dividerGrey),
              ),
              Column(
                children: [
                  UserInfoRow(
                    title: 'university'.tr(),
                    value: 'University Name',
                  ),
                  SizedBox(height: 12.h),
                  UserInfoRow(
                    title: 'college'.tr(),
                    value: 'IUST',
                  ),
                  SizedBox(height: 12.h),
                  UserInfoRow(
                    title: 'year'.tr(),
                    value: '3rd Year',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
