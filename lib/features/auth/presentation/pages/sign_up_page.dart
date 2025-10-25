import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/sign_up_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            top: 100.h,
            bottom: 50.h,
            right: 15.w,
            left: 15.w,
          ),
          child: Center(
            child: Column(
              children: [
                HeaderAuthPagesWidget(),
                SizedBox(height: 60.h),
                Text(
                  AppLocalizations.of(
                        context,
                      )?.translate("Lets_make_your_account") ??
                      "Let’s Make Your Account",
                  style: AppTextStyles.s16w600.copyWith(
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 30.h),
                SignUpFormWidget(),
                SizedBox(height: 40.h),
                InkWell(
                  onTap: () {
                    log("Don’t have an account?");
                  },
                  child: Text(
                    AppLocalizations.of(
                          context,
                        )?.translate("Already_have_an_account") ??
                        "Already have an account?",
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                CustomButtonWidget(
                  title:
                      AppLocalizations.of(context)?.translate("Log_in") ??
                      "Log In",
                  titleStyle: AppTextStyles.s16w500.copyWith(
                    fontFamily: AppTextStyles.fontGeist,
                    color: AppColors.titleBlack,
                  ),
                  buttonColor: AppColors.buttonWhite,
                  borderColor: AppColors.borderPrimary,
                  onTap: () {
                    context.go(RouteNames.logIn);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
