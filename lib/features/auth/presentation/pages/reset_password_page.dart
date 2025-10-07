import 'package:e_learning/core/constant/app_colors.dart';
import 'package:e_learning/core/constant/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/features/auth/presentation/widgets/form_reset_password_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/reset_password_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
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
                ResetPasswordButtonWidget(
                  borderColor: AppColors.buttonPrimary,
                  buttonColor: AppColors.buttonPrimary,
                  textColor: AppColors.titlePrimary,
                  formKey: _formKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
