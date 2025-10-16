import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_name_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_passowrd_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_phone_widget.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/pages/university_selection_page.dart';
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
          CustomButtonWidget(
            title: AppLocalizations.of(context)?.translate("next") ?? "Next",
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
                    message:
                        AppLocalizations.of(
                          context,
                        )?.translate("passwords_do_not_match") ??
                        "Passwords do not match",
                    title:
                        AppLocalizations.of(
                          context,
                        )?.translate("Information") ??
                        "Information",
                    backgroundColor: AppColors.messageWarning,
                  );
                  return;
                }
                log("✅ Form is valid");
                context.read<AuthCubit>().updateSignUpParams(
                  password: passwordController.text.trim(),
                  fullName: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                );
                context.push(
                  RouteNames.universitySelection,
                  extra: {
                    'blocProvide': BlocProvider.of<AuthCubit>(context),
                    'phone': phoneController.text.trim(),
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
