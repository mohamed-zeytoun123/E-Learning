import 'dart:developer';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/sign_up_form_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.background,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<AppManagerCubit>(context).toggleTheme();
          },
          icon: Icon(
            Icons.dark_mode,
            color: colors.iconBlack,
          ),
        ),
      ),
      backgroundColor: colors.background,
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
                  "lets_make_your_account".tr(),
                  style: AppTextStyles.s16w600.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                SizedBox(height: 30.h),
                SignUpFormWidget(),
                SizedBox(height: 40.h),
                InkWell(
                  onTap: () {
                    log("Don't have an account?");
                  },
                  child: Text(
                    "already_have_account".tr(),
                    style: AppTextStyles.s14w400.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                CustomButtonWidget(
                  title: "log_in".tr(),
                  titleStyle: AppTextStyles.s16w500.copyWith(
                    fontFamily: AppTextStyles.fontGeist,
                    color: colors.textPrimary,
                  ),
                  buttonColor: Colors.transparent,
                  borderColor: colors.textBlue,
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
