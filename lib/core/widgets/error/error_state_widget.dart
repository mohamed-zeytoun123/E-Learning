import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
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
              SizedBox(height: 30.h),

              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.s20w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 10.h),

              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.s16w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 30.h),

              CustomButtonWidget(
                title: retryText,
                titleStyle: AppTextStyles.s18w600.copyWith(
                  color: AppColors.titlePrimary,
                ),
                buttonColor: AppColors.buttonPrimary,
                borderColor: AppColors.borderPrimary,
                onTap: onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
