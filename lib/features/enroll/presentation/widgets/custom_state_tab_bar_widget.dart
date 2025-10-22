import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/enroll/data/models/enums/course_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStateTabBarWidget extends StatefulWidget {
  final Function(int)? onTabSelected;
  const CustomStateTabBarWidget({super.key, this.onTabSelected});

  @override
  State<CustomStateTabBarWidget> createState() =>
      _CustomStateTabBarWidgetState();
}

class _CustomStateTabBarWidgetState extends State<CustomStateTabBarWidget> {
  final List<String> tabs = CourseStateEnum.values
      .map((e) => e.name.replaceFirst(e.name[0], e.name[0].toUpperCase()))
      .toList();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTabSelected?.call(index);
            },
            child: AnimatedContainer(
              width: 112.w,
              height: 41.h,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                tabs[index],
                textAlign: TextAlign.center,
                style: AppTextStyles.s14w400.copyWith(
                  color: isSelected ? AppColors.textWhite : AppColors.textBlack,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
