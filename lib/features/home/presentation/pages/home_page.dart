import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/spacing.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/home/presentation/widgets/articles_section.dart';
import 'package:e_learning/features/home/presentation/widgets/course_slider.dart';
import 'package:e_learning/features/home/presentation/widgets/home_banner.dart';
import 'package:e_learning/features/home/presentation/widgets/custom_appbar.dart';
import 'package:e_learning/features/home/presentation/widgets/see_all_seperator.dart';
import 'package:e_learning/features/home/presentation/widgets/teatchers_slider.dart';
import 'package:e_learning/features/home/presentation/widgets/progress_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const double appBarHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.h,
            floating: false,
            pinned: false,
            backgroundColor: colors.background,
            automaticallyImplyLeading: false,
            clipBehavior: Clip.none,
            flexibleSpace: ClipRect(
              clipBehavior: Clip.none,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const CustomHomeAppBar(),
                  Positioned(
                    bottom: -100.h,
                    left: 16.w,
                    right: 16.w,
                    child: const ProgressCard(progress: 0.7),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: 130.sizedH,
          ),
          const SliverToBoxAdapter(
            child: HomeBannersWidget(),
          ),
          SliverToBoxAdapter(
            child: 24.sizedH,
          ),
          SliverToBoxAdapter(
            child: SeeAllSeperator(
              onTap: () {
                context.push(RouteNames.viewAllCourses);
              },
              title: 'recommended courses'.tr(),
            ),
          ),
          SliverToBoxAdapter(
            child: 24.sizedH,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.defaultScreen.copyWith(end: 0),
              child: BlocBuilder<CourseCubit, CourseState>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled:
                        state.categoriesStatus == ResponseStatusEnum.loading,
                    child: ChipsBar(
                      labels: context
                              .read<CourseCubit>()
                              .state
                              .categories
                              ?.map((e) => e.name)
                              .toList() ??
                          [],
                      onChipSelected: (value) {},
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.defaultScreen.copyWith(end: 0),
              child: const CourseSlider(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 48),
          ),
          SliverToBoxAdapter(
            child: SeeAllSeperator(
              onTap: () {
                context.push(RouteNames.viewAllTeachers);
              },
              title: 'top teachers'.tr(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.defaultScreen.copyWith(end: 0),
              child: const TeatchersSlider(maxItems: 3),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 48),
          ),
          SliverToBoxAdapter(
            child: SeeAllSeperator(
              onTap: () {
                context.push(RouteNames.viewAllArticles);
              },
              title: 'news and articles'.tr(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 36),
          ),
          const ArticlesSection(),
          SliverToBoxAdapter(
            child: 24.sizedH,
          ),
        ],
      ),
    );
  }
}
