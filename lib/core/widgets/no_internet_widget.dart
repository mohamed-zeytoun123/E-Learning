import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 100.r, color: AppColors.iconOrange),
              30.sizedH,
              Text(
                "No Internet Connection",
                textAlign: TextAlign.center,
                style: AppTextStyles.s20w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              10.sizedH,
              Text(
                "Please check your internet settings and try again.",
                textAlign: TextAlign.center,
                style: AppTextStyles.s16w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              30.sizedH,
              CustomButton(
                title: "Retry",
                buttonColor: AppColors.buttonPrimary,
                onTap: onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
