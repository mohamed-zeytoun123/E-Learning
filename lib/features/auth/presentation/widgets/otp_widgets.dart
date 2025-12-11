import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpInstructionWidget extends StatelessWidget {
  final String email;

  const OtpInstructionWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${"sent_code_to_phone".tr()} :\n$email ${"via_sms".tr()}",
          style: AppTextStyles.s12w400,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          "enter_code_below".tr(),
          style: AppTextStyles.s12w400,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OtpResendWidget extends StatelessWidget {
  final bool canResend;
  final int remainingSeconds;
  final VoidCallback onResend;

  const OtpResendWidget({
    super.key,
    required this.canResend,
    required this.remainingSeconds,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "didnt_receive_the_code".tr(),
            style: AppTextStyles.s12w400.copyWith(color: AppColors.textGrey),
          ),
          SizedBox(width: 8.w),
          if (!canResend)
            Text(
              "${remainingSeconds}s",
              style: AppTextStyles.s12w400.copyWith(
                color: AppColors.buttonPrimary,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            GestureDetector(
              onTap: onResend,
              child: Text(
                "resend".tr(),
                style: AppTextStyles.s12w400.copyWith(
                  color: AppColors.buttonPrimary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
