import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/course/presentation/widgets/course_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomCategoryTabBarWidget extends StatefulWidget {
  const CustomCategoryTabBarWidget({super.key});

  @override
  State<CustomCategoryTabBarWidget> createState() =>
      _CustomCategoryTabBarWidgetState();
}

class _CustomCategoryTabBarWidgetState
    extends State<CustomCategoryTabBarWidget> {
  final List<String> tabs = ["", "Programming", "Design", "Marketing"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors= context.colors;
    return Column(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 6.h),
          child: Row(
            children: List.generate(tabs.length, (index) {
              final bool isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.textBlue
                        : colors.buttonTapNotSelected,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      if (index == 0)
                        Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Icon(
                            Icons.tune,
                            size: 20.sp,
                            color: isSelected
                                ? colors.background
                                : colors.iconBlack,
                          ),
                        ),
                      if (tabs[index].isNotEmpty)
                        Text(
                          tabs[index],
                          style: AppTextStyles.s14w400.copyWith(
                            color: isSelected
                                ? colors.background
                                : colors.iconBlack,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 8.h),
        Divider(color: context.colors.dividerGrey, thickness: 1, height: 0.h),

        Expanded(
          child: Builder(
            builder: (_) {
              switch (selectedIndex) {
                case 0:
                  return const FilterWidget();
                case 1:
                  return const CategoryWidget1();
                case 2:
                  return const CategoryWidget2();
                case 3:
                  return const CategoryWidget3();
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => CourseInfoCardWidget(
          imageUrl: "https://picsum.photos/361/180",
          title: "Flutter Masterclass",
          subtitle: "Build beautiful apps",
          rating: 4.3,
          price: "25",
          onTap: () {
            context.push(RouteNames.courceInf);
            //todo Active
          },
          onSave: () {
            log("Course saved!");
          },
        ),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 15.h);
        },
      ),
    );
  }
}

class CategoryWidget1 extends StatelessWidget {
  const CategoryWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Category 1 Content Here", style: TextStyle(fontSize: 18.sp)),
    );
  }
}

class CategoryWidget2 extends StatelessWidget {
  const CategoryWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Category 2 Content Here", style: TextStyle(fontSize: 18.sp)),
    );
  }
}

class CategoryWidget3 extends StatelessWidget {
  const CategoryWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Category 3 Content Here", style: TextStyle(fontSize: 18.sp)),
    );
  }
}
