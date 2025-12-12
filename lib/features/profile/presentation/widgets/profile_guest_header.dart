import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileGuestHeader extends StatelessWidget {
  const ProfileGuestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: 198.h,
      width: 362.w,
      child: Card(
        color: colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: context.colors.borderCard),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          child: Column(
            children: [
              Text(
                'sign_in_to_gain_access'.tr(),
                style: AppTextStyles.s14w600.copyWith(
                  color: context.colors.textPrimary,
                ),
                maxLines: 1,
              ),
              SizedBox(height: 24.h),
              CustomButtonWidget(
                title: 'log_in'.tr(),
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: context.colors.titleBlack,
                ),
                buttonColor: Colors.transparent,
                borderColor: context.colors.textBlue,
                onTap: () {
                  GoRouter.of(context).go(RouteNames.logIn);
                },
              ),
              SizedBox(height: 12.h),
              CustomButtonWidget(
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: colors.textWhite,
                ),
                title: 'sign_up'.tr(),
                buttonColor: context.colors.textBlue,
                borderColor: Colors.transparent,
                onTap: () {
                  GoRouter.of(context).go(RouteNames.signUp);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
