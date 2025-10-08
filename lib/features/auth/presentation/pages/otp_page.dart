import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    String mobileNumber = "+20 123 456 7890"; // Example mobile number
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            top: 120.h,
            bottom: 50.h,
            right: 15.w,
            left: 15.w,
          ),
          child: Center(
            child: Column(
              children: [
                HeaderAuthPagesWidget(),
                SizedBox(height: 5.h),
                Text(
                  AppLocalizations.of(
                        context,
                      )?.translate("Lets_make_your_account") ??
                      "Let’s Make Your Account !",
                  style: AppTextStyles.s14w400.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: 80.h),
                Text(
                  AppLocalizations.of(context)?.translate("Otp_Verfication") ??
                      "OTP Verfication",
                  style: AppTextStyles.s16w600.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: 48.h),
                Text(
                  "${AppLocalizations.of(context)?.translate("We_Have_Sent_A_6-Digit_Code_To_The_Phone_Number") ?? "We Have Sent A 6-Digit Code To The Phone Number"} : \n $mobileNumber ${AppLocalizations.of(context)?.translate("Via_SMS") ?? "Via SMS"}",
                  style: AppTextStyles.s12w400,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  AppLocalizations.of(
                        context,
                      )?.translate("Please_Enter_The_Code_Down_Below") ??
                      "Please Enter the code below to verify",
                  style: AppTextStyles.s12w400,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                OtpTextField(
                  numberOfFields: 6,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  borderRadius: BorderRadius.circular(12.r),
                  borderColor: AppColors.borderBrand,
                  borderWidth: 1.w,
                  fieldWidth: 48.w,
                  fieldHeight: 48.h,
                  showFieldAsBox: true,
                  onCodeChanged:
                      (value) {}, // TODO: handle validation or checks
                  onSubmit: (value) {}, // TODO: handle submission
                ),
                SizedBox(height: 48.h),
                CustomButton(
                  title:
                      AppLocalizations.of(context)?.translate("Next") ?? "Next",
                  titleStyle: AppTextStyles.s16w500.copyWith(
                    fontFamily: AppTextStyles.fontGeist,
                    color: AppColors.titlePrimary,
                  ),
                  buttonColor: AppColors.buttonPrimary,
                  borderColor: AppColors.borderPrimary,
                  onTap: () {
                    context.go(RouteNames.resetPassword);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
