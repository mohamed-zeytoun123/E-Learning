import 'package:e_learning/core/widgets/bottom_nav_bar.dart';
import 'package:e_learning/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int curentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: curentIndex,
        onTap: (int selectedIndex) {
          setState(() {
            curentIndex = selectedIndex;
          });
        },
      ),
      body: pages[curentIndex],
    );
  }
}
