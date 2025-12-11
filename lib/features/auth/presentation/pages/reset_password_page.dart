import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/auth/data/models/params/reset_password_request_params.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/form_reset_password_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/reset_password_button_widger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.resetToken,
  });

  final String email;
  final String resetToken;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles the reset password process
  void _handleResetPassword() {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (isFormValid) {
      // Check if the widget is still mounted and cubit is available
      if (!mounted) return;

      final params = ResetPasswordRequestParams(
        email: widget.email,
        resetToken: widget.resetToken,
        newPassword: newPasswordController.text.trim(),
      );

      try {
        final authCubit = context.read<AuthCubit>();
        authCubit.resetPassword(params);
      } catch (e) {
        _showErrorMessage("An error occurred. Please try again.");
      }
    } else {
      _showErrorMessage("Please fill in all required fields correctly.");
    }
  }

  /// Shows error message using SnackBar
  void _showErrorMessage(String message) {
    AppMessage.showFlushbar(
      context: context,
      title: "wrong".tr(),
      mainButtonOnPressed: () {
        context.pop();
      },
      mainButtonText: "ok".tr(),
      iconData: Icons.error,
      backgroundColor: AppColors.messageError,
      message: message,
      isShowProgress: true,
    );
  }

  /// Shows success message using SnackBar
  void _showSuccessMessage(String message) {
    AppMessage.showFlushbar(
      context: context,
      iconData: Icons.check,
      backgroundColor: AppColors.messageSuccess,
      message: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Debug: Print the received parameters
    debugPrint('Reset Password Page - Phone: ${widget.email}');
    debugPrint('Reset Password Page - Reset Token: ${widget.resetToken}');

    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.resetPasswordState != current.resetPasswordState,
        listener: (context, state) {
          debugPrint(
            'BlocListener - Reset Password State: ${state.resetPasswordState}',
          );
          switch (state.resetPasswordState) {
            case ResponseStatusEnum.success:
              _showSuccessMessage("password_reset_successfully".tr());
              // Navigate to login page after successful reset using Future.microtask
              // to avoid state emission conflicts
              Future.microtask(() {
                if (context.mounted) {
                  context.go(RouteNames.logIn);
                }
              });
              break;
            case ResponseStatusEnum.failure:
              _showErrorMessage(
                state.resetPasswordError ?? "failed_to_reset_password".tr(),
              );
              break;
            case ResponseStatusEnum.loading:
            case ResponseStatusEnum.initial:
              break;
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: 120.h,
              bottom: 50.h,
              right: 15.w,
              left: 15.w,
            ),
            child: Center(
              child: Column(
                children: [
                  HeaderAuthPagesWidget(),
                  SizedBox(height: 150.h),
                  Text(
                    "set_new_password".tr(),
                    style: AppTextStyles.s16w600,
                  ),
                  SizedBox(height: 48.h),
                  Form(
                    key: _formKey,
                    child: FormResetPasswordWidget(
                      newPasswordController: newPasswordController,
                      confirmPasswordController: confirmPasswordController,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        previous.resetPasswordState !=
                        current.resetPasswordState,
                    builder: (context, state) {
                      return ResetPasswordButtonWidget(
                        borderColor: AppColors.borderBrand,
                        buttonColor: AppColors.buttonPrimary,
                        textColor: AppColors.titlePrimary,
                        formKey: _formKey,
                        isLoading:
                            state.resetPasswordState ==
                            ResponseStatusEnum.loading,
                        onResetPassword: _handleResetPassword,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
