import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_logo.dart';
import 'package:e_learning/core/widgets/custom_outlined_button.dart';
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
          icon: Icon(Icons.dark_mode, color: colors.iconBlack),
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
                AppLogo(),
                60.sizedH,
                Text(
                  "Lets_make_your_account".tr(),
                  style: AppTextStyles.s16w600.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                30.sizedH,
                SignUpFormWidget(),
                40.sizedH,
                InkWell(
                  onTap: () {
                    // Navigate to login if needed
                  },
                  child: Text(
                    "Already_have_an_account".tr(),
                    style: AppTextStyles.s14w400.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                10.sizedH,
                CustomOutlinedButton(
                  title: "Log_in".tr(),
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
