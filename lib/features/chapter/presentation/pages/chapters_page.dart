import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:flutter/material.dart';

class ChaptersPage extends StatelessWidget {
  const ChaptersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBarCourseWidget(title: "Course’s Title", showBack: true),
      // body: CustomCategoryTabBarWidget(),
    );
  }
}
