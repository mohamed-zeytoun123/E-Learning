import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/enroll/data/models/enums/course_state_enum.dart';
import 'package:easy_localization/easy_localization.dart';
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
  String _getTranslationKey(CourseStateEnum state) {
    switch (state) {
      case CourseStateEnum.active:
        return 'active';
      case CourseStateEnum.completed:
        return 'completed';
      case CourseStateEnum.suspended:
        return 'suspended';
    }
  }

  List<String> get tabs => CourseStateEnum.values
      .map((e) => _getTranslationKey(e).tr()) // Use translation instead of enum name
      .toList();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
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
                color: isSelected ? colors.textBlue : colors.buttonTapNotSelected,
                // Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                tabs[index],
                textAlign: TextAlign.center,
                style: AppTextStyles.s14w400.copyWith(
                  color: isSelected ? AppColors.textWhite : colors.textPrimary,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
