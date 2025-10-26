import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpInstructionWidget extends StatelessWidget {
  final String phone;

  const OtpInstructionWidget({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${AppLocalizations.of(context)?.translate("We_Have_Sent_A_6-Digit_Code_To_The_Phone_Number") ?? "We Have Sent A 6-Digit Code To The Phone Number"} :\n$phone ${AppLocalizations.of(context)?.translate("Via_SMS") ?? "Via SMS"}",
          style: AppTextStyles.s12w400,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          AppLocalizations.of(context)?.translate("Please_Enter_The_Code_Down_Below") ??
              "Please enter the code below to verify",
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
            AppLocalizations.of(context)?.translate("Didnt_receive_the_code") ??
                "Didn't receive the code?",
            style: AppTextStyles.s12w400.copyWith(
              color: AppColors.textGrey,
            ),
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
                AppLocalizations.of(context)?.translate("Resend") ?? "Resend",
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