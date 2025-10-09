import 'package:e_learning/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AppLoading {
  //?--------  circular ------------------------------------------------------------------------
  static Widget circular({
    double size = 40,
    double strokeWidth = 4,
    Color? color,
  }) {
    return SizedBox(
      width: size.w,
      height: size.w,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.loadingPrimary,
        ),
        backgroundColor: (color ?? AppColors.loadingPrimary).withOpacity(0.2),
      ),
    );
  }

  //?--------  linear ------------------------------------------------------------------------
  static Widget linear({double height = 6, Color? color}) {
    return SizedBox(
      height: height.h,
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.loadingPrimary,
        ),
        backgroundColor: (color ?? AppColors.loadingPrimary).withOpacity(0.2),
      ),
    );
  }

  //?--------  Skeleton ------------------------------------------------------------------------
  static Widget skeleton({
    double width = double.infinity,
    double height = 230,
  }) {
    return SizedBox(
      width: width == double.infinity ? double.infinity : width.w,
      height: height == double.infinity ? double.infinity : height.h,
      child: Shimmer.fromColors(
        baseColor: AppColors.loadingPrimary.withOpacity(0.15),
        highlightColor: AppColors.loadingPrimary.withOpacity(0.05),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: AppColors.loadingBackground,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  //?---------------------------------------------------------------------------------------------------
}
