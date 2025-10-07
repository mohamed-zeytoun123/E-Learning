import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final TextStyle titleStyle;
  final Color buttonColor;
  final Color borderColor;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.title,
    required this.titleStyle,
    required this.buttonColor,
    required this.borderColor,
    this.onTap,
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
        child: Text(title, style: titleStyle),
      ),
    );
  }
}
