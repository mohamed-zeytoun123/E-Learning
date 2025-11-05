import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_logo/app_logo_widget.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_dat_source.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_data_source_impl.dart';
import 'package:e_learning/features/profile/data/source/repo/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelectedMethodLogInPage extends StatelessWidget {
  const SelectedMethodLogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: Padding(
        padding: EdgeInsets.only(top: 430.h, bottom: 50.h),
        child: Center(
          child: Column(
            spacing: 10.h,
            children: [
              AppLogoWidget(imagePath: ""),
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate("Welcome To ‘AppName’") ??
                    "Welcome To ‘AppName’",

                style: AppTextStyles.s16w600.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: colors.textPrimary,
                ),
              ),
              Spacer(),
              CustomButtonWidget(
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: colors.background,
                ),
                title:
                    AppLocalizations.of(context)?.translate("Sign_up") ??
                    "Sign Up",

                buttonColor: colors.textBlue,
                borderColor: colors.textBlue,
                onTap: () {
                  GoRouter.of(context).go(RouteNames.signUp);
                },
              ),
              CustomButtonWidget(
                title:
                    AppLocalizations.of(context)?.translate("Log_in") ??
                    "Log In",
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: AppColors.titleBlack,
                ),
                buttonColor: AppColors.buttonSecondary,
                borderColor: AppColors.borderSecondary,
                onTap: () {
                  GoRouter.of(context).go(RouteNames.logIn);
                },
              ),
              CustomButtonWidget(
                title:
                    AppLocalizations.of(
                      context,
                    )?.translate("Continue_as_guest") ??
                    "Continue As A Guest",
                titleStyle: AppTextStyles.s16w500.copyWith(
                  fontFamily: AppTextStyles.fontGeist,
                  color: colors.textPrimary,
                ),
                buttonColor: Colors.transparent,
                borderColor: colors.textBlue,
                onTap: () {
                  GoRouter.of(context).go(RouteNames.profile);
                  // ProfileRemoteDataSourceImpl(
                  //   api: appLocator<API>(),
                  // ).getPrivacyPolicyinfo();
                  // ProfileRepository(
                  //   remote: ProfileRemoteDataSourceImpl(api: appLocator<API>()),
                  //   network: appLocator<NetworkInfoService>(),
                  // ).getPrivacyPolicyRepo();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
