import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModalSheetCustomContainerWidget extends StatelessWidget {
  final Widget child;
  final double height;
  const ModalSheetCustomContainerWidget({
    super.key,
    required this.child,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 40.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: child,
    );
  }
}
