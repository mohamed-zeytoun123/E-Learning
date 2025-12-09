import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/forgot_password_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/form_log_in_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/login_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderAuthPagesWidget(),
                SizedBox(height: 150.h),
                Text(
                  AppLocalizations.of(
                        context,
                      )?.translate("Log_in_to_your_account") ??
                      "Log In To Your Account",
                  style: AppTextStyles.s16w600.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 20.h),
                Form(
                  key: _formKey,
                  child: FormLogInWidget(
                    emailController: phoneController,
                    passwordController: passwordController,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ForgotPasswordWidget(
                    onTap: () {
                      context.push(RouteNames.forgetPassword);
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                LoginButtonWidget(
                  borderColor: AppColors.buttonPrimary,
                  buttonColor: AppColors.buttonPrimary,
                  textColor: AppColors.titlePrimary,
                  formKey: _formKey,
                  phoneController: phoneController,
                  passwordController: passwordController,
                ),
                SizedBox(height: 100.h),
                InkWell(
                  onTap: () {
                    log("Don’t have an account?");
                  },
                  child: Text(
                    AppLocalizations.of(
                          context,
                        )?.translate("Dont_have_an_account") ??
                        "Don’t have an account?",
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButtonWidget(
                  title:
                      AppLocalizations.of(context)?.translate("Sign_up") ??
                      "Sign Up",
                  titleStyle: AppTextStyles.s16w500.copyWith(
                    fontFamily: AppTextStyles.fontGeist,
                    color: AppColors.titleBlack,
                  ),
                  buttonColor: AppColors.buttonWhite,
                  borderColor: AppColors.borderPrimary,
                  onTap: () {
                    context.go(RouteNames.signUp);
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
