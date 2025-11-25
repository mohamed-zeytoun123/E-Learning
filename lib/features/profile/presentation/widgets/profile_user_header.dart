import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_cubit.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_state.dart';
import 'package:e_learning/features/profile/presentation/widgets/user_info_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileUserHeader extends StatelessWidget {
  const ProfileUserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoadingDataUserProfile == true) {
          return SizedBox(
            height: 198.h,
            width: 362.w,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.errorFetchDataUserInfoProfile != null) {
          return SizedBox(
            height: 500.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_tethering_error,
                    size: 64.sp,
                    color: context.colors.iconRed,
                  ),
                  16.sizedH,
                  Text(
                    'Error loading data User',
                    style: AppTextStyles.s16w500.copyWith(
                      color: context.colors.textPrimary,
                    ),
                  ),
                  8.sizedH,
                  Text(
                    state.errorFetchDataUserInfoProfile?.message ??
                        'Error loading data',
                    style: AppTextStyles.s14w400.copyWith(
                      color: context.colors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return SizedBox(
          height: 198.h,
          width: 362.w,
          child: Card(
            color: colors.background,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colors.borderCard),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              child: Column(
                children: [
                  Text(
                    state.dataUserInfoProfile.username,
                    style: AppTextStyles.s16w600.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Divider(color: colors.dividerGrey),
                  ),
                  Column(
                    children: [
                      UserInfoRow(
                        title: "University".tr(),
                        value: state.dataUserInfoProfile.universityName,
                      ),
                      12.sizedH,
                      UserInfoRow(
                        title: "College".tr(),
                        value: state.dataUserInfoProfile.collegeName,
                      ),
                      12.sizedH,
                      UserInfoRow(
                        title: "Year".tr(),
                        value: state.dataUserInfoProfile.studyYearName,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // }
        );
      },
    );
  }
}
