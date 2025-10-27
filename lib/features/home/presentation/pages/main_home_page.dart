import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/widgets/custom_bottom_navbar.dart';
import 'package:e_learning/features/Course/presentation/pages/courses_page.dart';
import 'package:e_learning/features/home/presentation/manager/tabs_cubit/tabs_cubit.dart';
import 'package:e_learning/features/home/presentation/manager/tabs_cubit/tabs_states.dart';
import 'package:e_learning/features/home/presentation/pages/home_content.dart';
import 'package:e_learning/features/home/presentation/pages/home_page_body.dart';
import 'package:e_learning/features/home/presentation/pages/view_all_articles.dart';
import 'package:e_learning/features/home/presentation/pages/view_all_courses.dart';
import 'package:e_learning/features/home/presentation/pages/view_all_teachers.dart';
import 'package:e_learning/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state.currentView != HomeView.home) {
              context.read<HomeCubit>().resetHomeView();
              return false;
            }

            return true;
          },
          child: Scaffold(
            body: IndexedStack(
              index: state.currentTabIndex,
              children: [
                HomeContent(),
                const Center(child: Text('Search Page')),
                const CoursesPage(),
                const Center(child: Text('Enrolls Page')),
                const ProfilePage(),
              ],
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: state.currentTabIndex,
              onTap: (index) => context.read<HomeCubit>().changeTab(index),
            ),
          ),
        );
      },
    );
  }
}
