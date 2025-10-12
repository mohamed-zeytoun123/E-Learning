import 'package:e_learning/features/home/presentation/widgets/course_card.dart';
import 'package:e_learning/features/home/presentation/widgets/teatcher_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeatchersSlider extends StatelessWidget {
  const TeatchersSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 16.w),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FittedBox(child: const TeatcherCard());
        },
      ),
    );
  }
}
