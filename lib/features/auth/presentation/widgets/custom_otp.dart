import 'package:e_learning/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOtp extends StatelessWidget {
  final void Function(String)? onCodeChanged;
  final void Function(String)? onSubmit;
  const CustomOtp({super.key, this.onCodeChanged, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      borderRadius: BorderRadius.circular(12.r),
      borderColor: AppColors.borderBrand,
      borderWidth: 1.w,
      fieldWidth: 48.w,
      fieldHeight: 48.h,
      showFieldAsBox: true,
      onCodeChanged: onCodeChanged,
      onSubmit: onSubmit,
    );
  }
}