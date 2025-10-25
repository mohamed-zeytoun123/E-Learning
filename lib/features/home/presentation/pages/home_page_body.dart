import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/features/home/presentation/widgets/articles_section.dart';
import 'package:e_learning/features/home/presentation/widgets/course_slider.dart';
import 'package:e_learning/features/home/presentation/widgets/home_banner.dart';
import 'package:e_learning/features/home/presentation/widgets/custom_appbar.dart';
import 'package:e_learning/features/home/presentation/widgets/see_all_seperator.dart';
import 'package:e_learning/features/home/presentation/widgets/teatchers_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  static const double appBarHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomHomeAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: 110.h),
          ),
          const SliverToBoxAdapter(
            child: HomeBannersWidget(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 48.h),
          ),
          SliverToBoxAdapter(
            child: SeeAllSeperator(
              onTap: () {},
              title: 'recommended_courses'.tr(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 24.h),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.appPadding.copyWith(end: 0),
              child: ChipsBar(
                labels: [
                  'by_default'.tr(),
                  'by_default'.tr(),
                  'by_default'.tr(),
                  'by_default'.tr(),
                ],
                onChipSelected: (value) {},
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.appPadding.copyWith(end: 0),
              child: const CourseSlider(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 48),
          ),
          SliverToBoxAdapter(
            child: SeeAllSeperator(
              onTap: () {},
              title: 'top_teachers'.tr(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.appPadding.copyWith(end: 0),
              child: const TeatchersSlider(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 48),
          ),
          SliverToBoxAdapter(
            child: SeeAllSeperator(
              onTap: () {},
              title: 'news_and_articles'.tr(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 36),
          ),
          // For ArticlesSection, wrap it as SliverList or SliverFixedExtentList
          const ArticlesSection(),
          SliverToBoxAdapter(
            child: SizedBox(height: 24.h), // bottom padding if needed
          ),
        ],
      ),
    );
  }
}
