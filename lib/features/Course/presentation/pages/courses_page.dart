import 'dart:developer';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/custom_category_tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocProvider<CourseCubit>(
      create: (context) => CourseCubit(repo: di<CourceseRepository>())
        ..getCategories()
        ..getCourses(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<CourseCubit>();

          return Scaffold(
            backgroundColor: colors.background,
            appBar: CustomAppBarWidget(
              title: "Course’s Title",
              showBack: true,
              onSearch: () {
                log("app search");

                // cubit.getColleges();
                // cubit.getUniversities();
                // cubit.getCategories();
                // cubit.getStudyYears();

                // showModalBottomSheet(
                //   isScrollControlled: true,
                //   context: context,
                //   builder: (_) => BlocProvider.value(
                //     value: cubit,
                //     child: const FiltersBottomSheetWidget(),
                //   ),
                // );
              },
            ),
            body: CustomCategoryTabBarWidget(),
          );
        },
      ),
    );
  }
}
