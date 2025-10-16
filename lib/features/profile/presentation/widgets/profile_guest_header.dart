import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileGuestHeader extends StatelessWidget {
  const ProfileGuestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 198.h,
      width: 362.w,
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: context.colors.borderBrand),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate("Sign_In_To_Gain_Access_To_Your_Courses") ??
                    "Sing In To Gain Access To Your Courses",
                style: AppTextStyles.s14w600.copyWith(
                  color: context.colors.textPrimary,
                ),
                maxLines: 1,
              ),
              SizedBox(height: 24.h),
              CustomButton(
                title:
                    AppLocalizations.of(context)?.translate("Log_in") ??
                    "Log In",
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: context.colors.titlePrimary,
                ),
                buttonColor: context.colors.buttonPrimary,
                borderColor: context.colors.borderBrand,
                onTap: () {
                  GoRouter.of(context).go(RouteNames.logIn);
                },
              ),
              SizedBox(height: 12.h),
              CustomButton(
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: context.colors.titleBlack,
                ),
                title:
                    AppLocalizations.of(context)?.translate("Sign_up") ??
                    "Sign Up",

                buttonColor: context.colors.buttonWhite,
                borderColor: context.colors.borderBrand,
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
