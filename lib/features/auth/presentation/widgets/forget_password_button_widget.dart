import 'dart:developer';

import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;

  const ForgetPasswordButtonWidget({
    super.key,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    required this.formKey,
    required this.phoneController,
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
            title:
                AppLocalizations.of(context)?.translate("wrrong") ?? "Wrrong",
            mainButtonOnPressed: () {
              Navigator.of(context).pop();
            },
            mainButtonText:
                AppLocalizations.of(context)?.translate("ok") ?? "Ok",
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
            message:
                AppLocalizations.of(
                  context,
                )?.translate("Request_sent_successfully") ??
                "Request sent successfully",
          );
        }
      },
      buildWhen: (pre, cur) =>
          pre.forgotPasswordState != cur.forgotPasswordState,
      builder: (context, state) {
        if (state.forgotPasswordState == ResponseStatusEnum.loading) {
          return AppLoading.circular();
        } else {
          return CustomButton(
            title: AppLocalizations.of(context)?.translate("Next") ?? "Next",
            titleStyle: AppTextStyles.s16w500.copyWith(
              fontFamily: AppTextStyles.fontGeist,
              color: textColor ?? AppColors.titleBlack,
            ),
            buttonColor: buttonColor ?? AppColors.buttonSecondary,
            borderColor: borderColor ?? AppColors.borderSecondary,
            onTap: () {
              if (formKey.currentState!.validate()) {
                log('Forget Password form is valid');
                context.read<AuthCubit>().forgotPassword(phoneController.text);
                // TODO:Add the parameter to the OTP screen
                context.push(RouteNames.otpScreen);
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
