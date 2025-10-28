import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_category_tab_bar_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/filters_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color=context.colors;
    return Scaffold(
      backgroundColor:color.background ,
      appBar: CustomAppBarWidget(
        title: "Course’s Title",
        showBack: true,
        onSearch: () {
          log("app search");
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const FiltersBottomSheetWidget(),
          );
        },
      ),
      body: CustomCategoryTabBarWidget(),
    );
  }
}
