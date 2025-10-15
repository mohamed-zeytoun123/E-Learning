import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBarBlack,
      titleTextStyle: AppTextStyles.s18w600.copyWith(
        color: AppColors.textWhite,
      ),
      foregroundColor: AppColors.textWhite,
    ),
    // Text Colors
    primaryColor: AppColors.textBlack,
    // Border Colors
    shadowColor: AppColors.borderBrand,
    hintColor: AppColors.borderSecondary,
    // Button Colors
    cardColor: AppColors.buttonPrimary,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBarWhite,
      titleTextStyle: AppTextStyles.s18w600.copyWith(
        color: AppColors.textBlack,
      ),
      foregroundColor: AppColors.textBlack,
    ),
    // Text Colors
    primaryColor: AppColors.textWhite,
    // Border Colors
    shadowColor: AppColors.borderBrand,
    hintColor: AppColors.borderSecondary,
    // Button Colors
    cardColor: AppColors.buttonSecondary,
  );
}
