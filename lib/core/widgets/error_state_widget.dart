import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback onRetry;
  final String retryText;

  const ErrorStateWidget({
    super.key,
    this.title = 'Wrong',
    required this.message,
    this.icon = Icons.error_outline,
    required this.onRetry,
    this.retryText = "Retry",
  });

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
              Icon(icon, size: 100.r, color: AppColors.iconOrange),
              30.sizedH,
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.s20w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              10.sizedH,
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.s16w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              30.sizedH,
              CustomButton(
                title: retryText,
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
