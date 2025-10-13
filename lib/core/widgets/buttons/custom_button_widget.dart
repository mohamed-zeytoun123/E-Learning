import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final Color buttonColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final Widget? icon;
  final double iconSpacing;

  const CustomButton({
    super.key,
    required this.title,
    required this.titleStyle,
    required this.buttonColor,
    required this.borderColor,
    this.onTap,
    this.icon,
    this.iconSpacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 361.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: borderColor),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: titleStyle),
            if (icon != null) ...[SizedBox(width: iconSpacing.w), icon!],
          ],
        ),
      ),
    );
  }
}
