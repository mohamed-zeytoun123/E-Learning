import 'dart:developer';
import 'package:e_learning/core/constant/app_colors.dart';
import 'package:e_learning/core/constant/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_name_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_passowrd_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_phone_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  @override
  void dispose() {
    passwordController.dispose();
    phoneController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10.h,
        children: [
          InputPhoneWidget(controller: phoneController),
          InputPasswordWidget(
            controller: passwordController,
            hint: 'Password',
            hintKey: 'Password',
          ),
          InputNameWidget(
            controller: nameController,
            hint: 'Full Name',
            hintKey: 'Full_name',
          ),
          InputPasswordWidget(
            controller: confirmPasswordController,
            hint: 'Confirm Password',
            hintKey: 'Confirm_password',
          ),
          CustomButton(
            title: AppLocalizations.of(context)?.translate("next") ?? "Next",
            titleStyle: AppTextStyles.s16w500.copyWith(
              color: AppColors.titlePrimary,
            ),
            buttonColor: AppColors.buttonPrimary,
            borderColor: AppColors.borderPrimary,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                log("✅ Form is valid");
                //todo push otp
                // context.push(RouteNames.logIn);
              } else {
                log("⚠️ Please fill all required fields correctly");
              }
            },
          ),
        ],
      ),
    );
  }
}
