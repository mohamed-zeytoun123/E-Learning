import 'package:e_learning/core/widgets/input_passowrd_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormResetPasswordWidget extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  const FormResetPasswordWidget({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 7.h,
      children: [
        InputPasswordWidget(
          controller: newPasswordController,
          hint: 'New Password',
          hintKey: 'New_Password',
        ),
        InputPasswordWidget(
          controller: confirmPasswordController,
          hint: 'Confirm New Password',
          hintKey: 'Confirm_New_Password',
        ),
      ],
    );
  }
}
