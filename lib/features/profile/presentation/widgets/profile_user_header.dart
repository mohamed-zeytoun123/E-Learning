import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_cubit.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_state.dart';
import 'package:e_learning/features/profile/presentation/widgets/user_info_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileUserHeader extends StatelessWidget {
  const ProfileUserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // if (state.isLoadingDataUserProfile == true) {
        //   return SizedBox(
        //     height: 198.h,
        //     width: 362.w,
        //     child: Center(child: CircularProgressIndicator()),
        //   );
        // } 
        if(state.errorFetchDataUserInfoProfile!=null){
          return SizedBox(height: 300.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wifi_tethering_error,
                              size: 64.sp,
                              color: context.colors.iconRed,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'error_loading_user_data'.tr(),
                              style: AppTextStyles.s16w500.copyWith(
                                color: context.colors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              state.errorFetchDataUserInfoProfile!.message,
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
          // height: 198.h,
          width: 362.w,
          // var dataUser= state.dataUserInfoProfile;
          child: Skeletonizer(
            enabled:  state.isLoadingDataUserProfile == true,
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
                      // AppLocalizations.of(context)?.translate("User_Name") ??
                      //     "University",
                      state.dataUserInfoProfile.fullName,
                      style: AppTextStyles.s16w600.copyWith(
                        color: context.colors.textPrimary,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Divider(color: colors.dividerGrey),
                    ),
                    Column(
                      children: [
                        UserInfoRow(
                          title: 'university'.tr(),
                          value: state.dataUserInfoProfile.universityName,
                        ),
                        SizedBox(height: 12.h),
                        UserInfoRow(
                          title: 'college'.tr(),
                          value: state.dataUserInfoProfile.collegeName,
                        ),
                        SizedBox(height: 12.h),
                        UserInfoRow(
                          title: 'year'.tr(),
                          value: state.dataUserInfoProfile.studyYearName,
                        ),
                        SizedBox(height: 12.h),
                        UserInfoRow(
                          title: 'email'.tr(),
                          value: state.dataUserInfoProfile.email,
                        ),
                        SizedBox(height: 12.h),
                        UserInfoRow(
                          title: 'phone_number'.tr(),
                          value: state.dataUserInfoProfile.phone,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // }
        );
      },
    );
  }
}
