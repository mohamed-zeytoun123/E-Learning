import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyles {
  static const String _fontFamily = 'Inter';

  static TextStyle _baseStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) => TextStyle(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    fontFamily: _fontFamily,
    height: height,
  );
  //?------------ Types ---------------------------------
  static TextStyle get s14w400 => _baseStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  //?----------------------------------------------------
}
