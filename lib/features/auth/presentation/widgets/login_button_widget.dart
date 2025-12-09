import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/network/app_dio.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginButtonWidget extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  const LoginButtonWidget({
    super.key,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    required this.formKey,
    required this.phoneController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (pre, cur) => pre.loginState != cur.loginState,
      listener: (context, state) {
        if (state.loginState == ResponseStatusEnum.failure ||
            state.loginError != null) {
          AppMessage.showFlushbar(
            context: context,
            title:
                AppLocalizations.of(context)?.translate("wrrong") ?? "Wrrong",
            mainButtonOnPressed: () {
              context.pop();
            },
            mainButtonText:
                AppLocalizations.of(context)?.translate("ok") ?? "Ok",
            iconData: Icons.error,
            backgroundColor: AppColors.messageError,
            message: state.loginError,
            isShowProgress: true,
          );
        } else if (state.loginState == ResponseStatusEnum.success) {
          // final token = state.user?.access ?? "";
          if (state.user != null) {
            final token = state.user?.access ?? "";
            appLocator<AppDio>().addTokenToHeader(token);
          }
          AppMessage.showFlushbar(
            isShowProgress: true,
            title: "Successful",
            context: context,
            iconData: Icons.check,
            backgroundColor: AppColors.messageSuccess,
            message:
                AppLocalizations.of(context)?.translate("Login_successful") ??
                "Login successful",
          );
        }
      },
      buildWhen: (pre, cur) => pre.loginState != cur.loginState,
      builder: (context, state) {
        if (state.loginState == ResponseStatusEnum.loading) {
          return AppLoading.circular();
        } else {
          return CustomButtonWidget(
            title:
                AppLocalizations.of(context)?.translate("Log_in") ?? "Log In",
            titleStyle: AppTextStyles.s16w500.copyWith(
              fontFamily: AppTextStyles.fontGeist,
              color: textColor ?? AppColors.titleBlack,
            ),
            buttonColor: buttonColor ?? AppColors.buttonSecondary,
            borderColor: borderColor ?? AppColors.borderSecondary,
            onTap: () {
              if (formKey.currentState!.validate()) {
                log("Login success ${phoneController.text} ");
                context.read<AuthCubit>().login(
                  phoneController.text.trim(),
                  passwordController.text.trim(),
                );
              } else {
                log("Form not valid");
              }
            },
          );
        }
      },
    );
  }
}
