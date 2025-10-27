import 'package:e_learning/features/home/presentation/manager/tabs_cubit/tabs_cubit.dart';
import 'package:e_learning/features/home/presentation/manager/tabs_cubit/tabs_states.dart';
import 'package:e_learning/features/home/presentation/pages/home_page_body.dart';
import 'package:e_learning/features/home/presentation/pages/view_all_articles.dart';
import 'package:e_learning/features/home/presentation/pages/view_all_courses.dart';
import 'package:e_learning/features/home/presentation/pages/view_all_teachers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.currentView) {
          case HomeView.home:
            return const HomePage();
          case HomeView.articles:
            return const ViewAllArticles();
          case HomeView.courses:
            return const ViewAllCourses();
          case HomeView.teachers:
            return const ViewAllTeachers();
        }
      },
    );
  }
  }
