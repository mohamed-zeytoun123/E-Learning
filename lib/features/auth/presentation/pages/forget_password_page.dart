import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/input_forms/input_email_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/forget_password_button_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
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
                      )?.translate("Enter_Your_Phone_Number") ??
                      "Enter Your Phone Number",
                  style: AppTextStyles.s16w600,
                ),
                SizedBox(height: 48.h),
                Form(
                  key: _formKey,
                  child: InputEmailWidget(controller: emailController),
                ),
                SizedBox(height: 12.h),
                ForgetPasswordButtonWidget(
                  borderColor: AppColors.borderBrand,
                  buttonColor: Theme.of(context).colorScheme.primary,
                  textColor: AppColors.titlePrimary,
                  formKey: _formKey,
                  phoneController: emailController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
