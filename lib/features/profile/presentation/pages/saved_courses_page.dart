import 'dart:developer';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedCoursesPage extends StatelessWidget {
  const SavedCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Saved Courses', showBack: true),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w, vertical: 32.h),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => CourseInfoCardWidget(
            onTap: () {},
            imageUrl: "https://picsum.photos/361/180",
            title: "Flutter Masterclass",
            subtitle: "Build beautiful apps",
            rating: 4.3,
            price: "25",
            onSave: () {
              log("Course saved!");
            },
          ),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 22.h);
          },
        ),
      ),
    );
  }
}
