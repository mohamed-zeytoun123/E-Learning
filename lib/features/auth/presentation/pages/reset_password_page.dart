import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/app_logo.dart';
import 'package:e_learning/features/auth/data/models/params/reset_password_request_params.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/form_reset_password_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/reset_password_button_widger.dart';
import 'package:easy_localization/easy_localization.dart';
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

  /// Handles the reset password process
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
        _showErrorMessage("An_error_occurred_Please_try_again".tr());
      }
    } else {
      _showErrorMessage("Please_fill_in_all_required_fields_correctly".tr());
    }
  }

  /// Shows error message using SnackBar
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Shows success message using SnackBar
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.resetPasswordState != current.resetPasswordState,
        listener: (context, state) {
          switch (state.resetPasswordState) {
            case ResponseStatusEnum.success:
              _showSuccessMessage("Password_reset_successfully".tr());
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
                state.resetPasswordError ?? "Failed_to_reset_password".tr(),
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
                  AppLogo(),
                  150.sizedH,
                  Text(
                    "Set_A_New_Password".tr(),
                    style: AppTextStyles.s16w600,
                  ),
                  48.sizedH,
                  Form(
                    key: _formKey,
                    child: FormResetPasswordWidget(
                      newPasswordController: newPasswordController,
                      confirmPasswordController: confirmPasswordController,
                    ),
                  ),
                  12.sizedH,
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
                        isLoading: state.resetPasswordState ==
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
