import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:e_learning/core/widgets/input_forms/input_name_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_passowrd_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_email_widget.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Add FocusNodes for controlling focus between fields
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();

    // Dispose FocusNodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10.h,
        children: [
          InputEmailWidget(
            controller: emailController,
            focusNode: _emailFocusNode,
            nextFocusNode:
                _passwordFocusNode, // Move focus to password field next
          ),
          InputPasswordWidget(
            controller: passwordController,
            hint: 'Password',
            hintKey: 'Password',
            focusNode: _passwordFocusNode,
            nextFocusNode: _nameFocusNode, // Move focus to name field next
          ),
          InputNameWidget(
            controller: nameController,
            hint: 'Full Name',
            hintKey: 'Full_name',
            focusNode: _nameFocusNode,
            nextFocusNode:
                _confirmPasswordFocusNode, // Move focus to confirm password field next
          ),
          InputPasswordWidget(
            controller: confirmPasswordController,
            hint: 'Confirm Password',
            hintKey: 'Confirm_password',
            focusNode: _confirmPasswordFocusNode,
          ),
          CustomButtonWidget(
            title: "next".tr(),
            titleStyle: AppTextStyles.s16w500.copyWith(
              color: AppColors.titlePrimary,
            ),
            buttonColor: AppColors.buttonPrimary,
            borderColor: AppColors.borderPrimary,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                if (passwordController.text != confirmPasswordController.text) {
                  passwordController.clear();
                  confirmPasswordController.clear();
                  AppMessage.showFlushbar(
                    context: context,
                    iconData: Icons.lock_outline,
                    isShowProgress: true,
                    message: "passwords_do_not_match".tr(),
                    title: "information".tr(),
                    backgroundColor: AppColors.messageWarning,
                  );
                  return;
                }
                log("✅ Form is valid");
                context.read<AuthCubit>().updateSignUpParams(
                  password: passwordController.text.trim(),
                  fullName: nameController.text.trim(),
                  email: emailController.text.trim(),
                );
                context.push(
                  RouteNames.universitySelection,
                  extra: {
                    'blocProvide': BlocProvider.of<AuthCubit>(context),
                    'email': emailController.text.trim(),
                  },
                );
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
