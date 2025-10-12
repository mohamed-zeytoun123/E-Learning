import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyles {
  static const String _fontFamily = 'Inter';
  static const String fontGeist = 'Geist';

  static TextStyle _baseStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) =>
      TextStyle(
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
        fontFamily: _fontFamily,
        height: height,
      );

  //?------------ Types ---------------------------------

  static TextStyle get s12w400 => _baseStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );

  static TextStyle get s14w400 => _baseStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      );

  static TextStyle get s14w500 => _baseStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle get s16w500 => _baseStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle get s16w600 => _baseStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );
  static TextStyle get s18w600 => _baseStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  //?----------------------------------------------------
}
