import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/widgets/app_logo/app_logo_widget.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelectedMethodLogInPage extends StatelessWidget {
  const SelectedMethodLogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: Padding(
        padding: EdgeInsets.only(top: 430.h, bottom: 50.h),
        child: Center(
          child: Column(
            spacing: 10.h,
            children: [
              AppLogoWidget(imagePath: ""),
              Text(
                "welcome".tr(),
                style: AppTextStyles.s16w600.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: AppColors.textBlack,
                ),
              ),
              Spacer(),
              CustomButtonWidget(
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: AppColors.titlePrimary,
                ),
                title: "sign_up".tr(),
                buttonColor: AppColors.buttonPrimary,
                borderColor: AppColors.borderPrimary,
                onTap: () {
                  GoRouter.of(context).go(RouteNames.signUp);
                },
              ),
              CustomButtonWidget(
                title: "log_in".tr(),
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: AppColors.textPrimary,
                ),
                buttonColor: AppColors.buttonSecondary,
                borderColor: AppColors.borderSecondary,
                onTap: () {
                  GoRouter.of(context).go(RouteNames.logIn);
                },
              ),
              CustomButtonWidget(
                title: "continue_as_guest".tr(),
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: AppColors.textPrimary,
                ),
                buttonColor: AppColors.buttonWhite,
                borderColor: AppColors.borderPrimary,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
