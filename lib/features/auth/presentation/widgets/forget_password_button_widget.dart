import 'dart:developer';

import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  const ForgetPasswordButtonWidget({
    super.key,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    required this.formKey,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (pre, cur) =>
          pre.forgotPasswordState != cur.forgotPasswordState,
      listener: (context, state) {
        if (state.forgotPasswordState == ResponseStatusEnum.failure ||
            state.forgotPasswordError != null) {
          AppMessage.showFlushbar(
            context: context,
            title: "wrong".tr(),
            mainButtonOnPressed: () {
              context.pop();
            },
            mainButtonText: "ok".tr(),
            iconData: Icons.error,
            backgroundColor: AppColors.messageError,
            message: state.forgotPasswordError,
            isShowProgress: true,
          );
        } else if (state.forgotPasswordState == ResponseStatusEnum.success) {
          AppMessage.showFlushbar(
            context: context,
            iconData: Icons.check,
            backgroundColor: AppColors.messageSuccess,
            message: "request_sent_successfully".tr(),
          );
        }
      },
      buildWhen: (pre, cur) =>
          pre.forgotPasswordState != cur.forgotPasswordState,
      builder: (context, state) {
        if (state.forgotPasswordState == ResponseStatusEnum.loading) {
          return AppLoading.circular();
        } else {
          return CustomButtonWidget(
            title: "next".tr(),
            titleStyle: AppTextStyles.s16w500.copyWith(
              fontFamily: AppTextStyles.fontGeist,
              color: textColor ?? AppColors.titleBlack,
            ),
            buttonColor: buttonColor ?? AppColors.buttonSecondary,
            borderColor: borderColor ?? AppColors.borderSecondary,
            onTap: () {
              if (formKey.currentState!.validate()) {
                log('Forget Password form is valid');
                context.read<AuthCubit>().forgotPassword(emailController.text);
                context.push(
                  RouteNames.otpScreen,
                  extra: {
                    'blocProvide': BlocProvider.of<AuthCubit>(context),
                    'email': emailController.text.trim(),
                    'purpose': 'reset',
                  },
                );
              } else {
                log('Forget Password form is not valid');
              }
            },
          );
        }
      },
    );
  }
}
