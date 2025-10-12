import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/features/home/presentation/pages/home_page_body.dart';
import 'package:e_learning/features/home/presentation/widgets/top_home_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HomePageBody(),
          PositionedDirectional(
              top: 110.h,
              start: 0,
              end: 0,
              child: const Padding(
                padding: AppPadding.appPadding,
                child: TopHomeSection(),
              ))
        ],
      ),
    );
  }
}
