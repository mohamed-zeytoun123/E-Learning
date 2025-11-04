import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
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
    required this.phone,
    required this.resetToken,
  });

  final String phone;
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

  void _handleResetPassword() {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (isFormValid) {
      // Check if the widget is still mounted and cubit is available
      if (!mounted) return;

      final params = ResetPasswordRequestParams(
        phone: widget.phone,
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

  void _showErrorMessage(String message) {
    AppMessage.showSnackBar(
      context: context,
      message: message,
      backgroundColor: AppColors.textError,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.resetPasswordState != current.resetPasswordState,
        listener: (context, state) {
          switch (state.resetPasswordState) {
            case ResponseStatusEnum.success:
              // Navigate immediately without showing SnackBar to avoid widget lifecycle issues
              if (mounted) {
                context.go(RouteNames.logIn);
              }
              break;
            case ResponseStatusEnum.failure:
              if (mounted) {
                _showErrorMessage(
                  state.resetPasswordError ??
                      (AppLocalizations.of(
                            context,
                          )?.translate("Failed_to_reset_password") ??
                          "Failed to reset password"),
                );
              }
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
                    AppLocalizations.of(
                          context,
                        )?.translate("Set_A_New_Password") ??
                        "Set A New Password",
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
