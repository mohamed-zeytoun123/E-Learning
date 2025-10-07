import 'package:e_learning/core/widgets/input_forms/input_passowrd_widget.dart';
import 'package:e_learning/core/widgets/input_forms/input_phone_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormLogInWidget extends StatelessWidget {
  const FormLogInWidget({
    super.key,
    required this.phoneController,
    required this.passwordController,
  });

  final TextEditingController phoneController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 7.h,
      children: [
        InputPhoneWidget(controller: phoneController),
        InputPasswordWidget(
          controller: passwordController,
          hint: 'Password',
          hintKey: 'Password',
        ),
      ],
    );
  }
}
