// ✅ StepsDotsIndicator (no change needed except small visual tweak)
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepsDotsIndecator extends StatefulWidget {
  const StepsDotsIndecator({
    super.key,
    required this.selectedIndex,
    required this.stepsCount,
  });

  final int selectedIndex;
  final int stepsCount;

  @override
  State<StepsDotsIndecator> createState() => _StepsDotsIndecatorState();
}

class _StepsDotsIndecatorState extends State<StepsDotsIndecator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.stepsCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: widget.selectedIndex == index ? 20.w : 8.w,
          decoration: BoxDecoration(
            color: widget.selectedIndex == index
                ? AppColors.iconBlue
                : const Color(0xffDBE4EB),
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
      ),
    );
  }
}
