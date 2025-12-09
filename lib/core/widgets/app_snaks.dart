import 'package:another_flushbar/flushbar.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSnacksService {
  void showSuccess(BuildContext context, String message);
  void showError(BuildContext context, String message);
  void showWarning(BuildContext context, String message);
}

class AppMessageServiceImpl implements AppSnacksService {
  Flushbar<dynamic>? _currentFlushbar;

  void _showFlushbar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    IconData? icon,
  }) {
    // Prevent multiple flushbars
    if (_currentFlushbar != null) return;

    backgroundColor ??= AppColors.messageError;

    _currentFlushbar = Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      borderRadius: BorderRadius.circular(12.r),
      backgroundColor: backgroundColor,
      duration: const Duration(milliseconds: 1500),
      icon: icon != null ? Icon(icon, size: 28.sp, color: Colors.white) : null,
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    );

    _currentFlushbar!.show(context).then((_) => _currentFlushbar = null);
  }

  @override
  void showError(BuildContext context, String message) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: AppColors.messageError,
      icon: Icons.error_outline,
    );
  }

  @override
  void showSuccess(BuildContext context, String message) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: AppColors.messageSuccess,
      icon: Icons.check_circle_outline,
    );
  }

  @override
  void showWarning(BuildContext context, String message) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: AppColors.messageWarning,
      icon: Icons.warning_amber_rounded,
    );
  }
}

// Singleton instance for easy access
final AppMessage = AppMessageServiceImpl();
