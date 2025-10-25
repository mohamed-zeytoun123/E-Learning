import 'package:e_learning/core/widgets/custom_bottom_navbar.dart';
import 'package:e_learning/features/home/presentation/pages/home_page.dart';
import 'package:e_learning/features/home/presentation/pages/home_page_body.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int currentIndex = 0;

  // Your tab pages
  final List<Widget> pages = const [
    HomePage(),
    Center(child: Text('Courses Page')),
    Center(child: Text('Saved Page')),
    Center(child: Text('Profile Page')),
    Center(child: Text('Settings Page')),
  ];

  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabSelected,
      ),
    );
  }
}
