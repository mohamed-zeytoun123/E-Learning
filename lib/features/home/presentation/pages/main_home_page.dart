import 'package:e_learning/core/widgets/custom_bottom_navbar.dart';
import 'package:e_learning/features/Course/presentation/pages/courses_page.dart';
import 'package:e_learning/features/home/presentation/pages/home_content.dart';
import 'package:e_learning/features/home/presentation/pages/search_page.dart';
import 'package:e_learning/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentTabIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
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
          Center(child: Text('Enrolls Page')),
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
