import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_message.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/input_name_widget.dart';
import 'package:e_learning/core/widgets/input_passowrd_widget.dart';
import 'package:e_learning/core/widgets/input_phone_widget.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
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
          CustomButton(
            title: "next".tr(),
            buttonColor: context.colors.textBlue,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                if (passwordController.text != confirmPasswordController.text) {
                  passwordController.clear();
                  confirmPasswordController.clear();
                  AppMessage.showWarning(context, "passwords_do_not_match".tr());
                  return;
                }
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
              }
            },
          ),
        ],
      ),
    );
  }
}
