import 'package:e_learning/core/widgets/bottom_nav_bar.dart';
import 'package:e_learning/features/Course/presentation/pages/courses_page.dart';
import 'package:e_learning/features/home/presentation/pages/home_content.dart';
import 'package:e_learning/features/home/presentation/pages/search_page.dart';
import 'package:e_learning/features/profile/presentation/pages/profile_page.dart';
import 'package:e_learning/features/enroll/presentation/pages/enroll_page.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => MainHomePageState();
}

class MainHomePageState extends State<MainHomePage> {
  int _currentTabIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  // Public method to change tab from child widgets
  void changeTab(int index) {
    _changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          const HomeContent(),
          const SearchPage(),
          const CoursesPage(),
          const EnrollPage(),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _changeTab,
      ),
    );
  }
}
