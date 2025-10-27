import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 68.h,
        elevation: 0,
        color: AppColors.primaryColor,
        titleTextStyle: AppTextStyles.s18w600.copyWith(color: Colors.white)),
    scaffoldBackgroundColor: AppColors.background,
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(0),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      textStyle: WidgetStateProperty.all(AppTextStyles.s14w400),
      hintStyle: WidgetStateProperty.all(AppTextStyles.s14w400),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor.withOpacity(0.3),
      selectionHandleColor: AppColors.primaryColor,
    ),
  );

  static final ThemeData dark = light.copyWith();
}
