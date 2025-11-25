import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyles {
  static const String _fontFamily = 'Inter';

  static TextStyle _baseStyle({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) =>
      TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
        fontFamily: _fontFamily,
      );

  //?------------ Types ---------------------------------

  static TextStyle get s12w400 => _baseStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSolidBlack,
      );

  static TextStyle get s14w400 => _baseStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSolidBlack,
      );

  static TextStyle get s14w500 => _baseStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSolidBlack,
      );

  static TextStyle get s14w600 => _baseStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSolidBlack,
      );

  static TextStyle get s16w400 => _baseStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textSolidBlack,
      );

  static TextStyle get s16w500 => _baseStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textSolidBlack,
      );

  static TextStyle get s16w600 => _baseStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textSolidBlack,
      );

  static TextStyle get s18w600 => _baseStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textSolidBlack,
      );

  static TextStyle get s20w600 => _baseStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textSolidBlack,
      );
}
