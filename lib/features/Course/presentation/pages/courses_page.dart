import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/features/course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_category_tab_bar_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/filters_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CourseCubit>(
      create: (context) => CourseCubit(repo: appLocator<CourceseRepository>())
        ..getColleges()
        ..getCourses(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundPage,
        appBar: CustomAppBarCourseWidget(
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
      ),
    );
  }
}
