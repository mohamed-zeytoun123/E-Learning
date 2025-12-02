import 'package:e_learning/core/widgets/input_forms/input_passowrd_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_email_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormLogInWidget extends StatelessWidget {
  const FormLogInWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 7.h,
      children: [
        InputEmailWidget(controller: emailController),
        InputPasswordWidget(
          controller: passwordController,
          hint: 'Password',
          hintKey: 'Password',
        ),
      ],
    );
  }
}
