import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogoWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;

  const AppLogoWidget({
    super.key,
    required this.imagePath,
    this.width = 150,
    this.height = 50,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        color: Colors.amber,
        // image: DecorationImage(
        //   image: AssetImage(imagePath),
        //   fit: BoxFit.contain,
        // ),
      ),
    );
  }
}
