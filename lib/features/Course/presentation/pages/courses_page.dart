import 'dart:developer';

import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_category_tab_bar_widget.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarCourseWidget(
        title: "dsf",
        showBack: true,
        onSearch: () {
          log("app search");
        },
      ),
      body: CustomCategoryTabBarWidget(),
    );
  }
}
