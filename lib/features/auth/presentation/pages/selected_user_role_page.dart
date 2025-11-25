import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/spacing.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_logo.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/custom_outlined_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelecteUserRolePage extends StatelessWidget {
  const SelecteUserRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.defaultScreen,
        child: Column(
          spacing: 16.h,
          children: [
            const Spacer(flex: 5),
            const AppLogo(),
            Text(
              "welcome_to_appname".tr(),
              style: AppTextStyles.s16w600.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            const Spacer(),
            CustomButton(
              title: "sign_up".tr(),
              onTap: () => GoRouter.of(context).push(RouteNames.signUp),
            ),
            CustomButton(
              title: "log_in".tr(),
              buttonColor: AppColors.ligthPrimary,
              onTap: () => GoRouter.of(context).push(RouteNames.logIn),
              textColor: context.colors.textBlue,
            ),
            CustomOutlinedButton(
              title: "continue_as_guest".tr(),
              onTap: () => GoRouter.of(context).go(RouteNames.profile),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
