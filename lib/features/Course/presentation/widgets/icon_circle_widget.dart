import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconCircleWidget extends StatelessWidget {
  const IconCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.circle, size: 7.r, color: AppColors.iconCircle);
  }
}
