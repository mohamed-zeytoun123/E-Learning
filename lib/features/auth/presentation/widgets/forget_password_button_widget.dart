import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/widgets/app_loading_widget.dart';
import 'package:e_learning/core/widgets/app_message.dart' show AppMessage;
import 'package:e_learning/core/widgets/custom_button.dart';
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
          AppMessage.showError(context, state.forgotPasswordError ?? "wrrong".tr());
        } else if (state.forgotPasswordState == ResponseStatusEnum.success) {
          AppMessage.showSuccess(context, "Request_sent_successfully".tr());
        }
      },
      buildWhen: (pre, cur) =>
          pre.forgotPasswordState != cur.forgotPasswordState,
      builder: (context, state) {
        return AppLoadingWidget(
          isLoading: state.forgotPasswordState == ResponseStatusEnum.loading,
          child: CustomButton(
            title: "Next".tr(),
            buttonColor: buttonColor ?? AppColors.buttonSecondary,
            onTap: state.forgotPasswordState == ResponseStatusEnum.loading
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthCubit>().forgotPassword(phoneController.text);
                      context.push(
                        RouteNames.otpScreen,
                        extra: {
                          'blocProvide': BlocProvider.of<AuthCubit>(context),
                          'phone': phoneController.text.trim(),
                          'purpose': 'reset',
                        },
                      );
                    }
                  },
          ),
        );
      },
    );
  }
}
