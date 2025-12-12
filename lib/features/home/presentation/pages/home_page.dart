import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/home/presentation/pages/main_home_page.dart';
import 'package:e_learning/features/home/presentation/widgets/articles_section.dart';
import 'package:e_learning/features/home/presentation/widgets/course_slider.dart';
import 'package:e_learning/features/home/presentation/widgets/home_banner.dart';
import 'package:e_learning/features/home/presentation/widgets/custom_appbar.dart';
import 'package:e_learning/features/home/presentation/widgets/see_all_seperator.dart';
import 'package:e_learning/features/home/presentation/widgets/teatchers_slider.dart';
import 'package:e_learning/features/home/presentation/widgets/progress_card.dart';
import 'package:e_learning/features/home/presentation/widgets/top_home_section.dart';
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
      backgroundColor: AppColors.background,
      body: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          // Determine if progress card should be shown
          final showProgressCard =
              state.myCoursesStatus == ResponseStatusEnum.success &&
                  state.myCourses != null &&
                  state.myCourses!.results.isNotEmpty;

          // Dynamic height and bottom based on card type
          final expandedHeight = showProgressCard ? 250.h : 194.h;
          final bottomPosition = showProgressCard ? -87.h : -40.h;
          final spacingHeight = showProgressCard ? 130.h : 100.h;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: expandedHeight,
                floating: false,
                pinned: false,
                backgroundColor: AppColors.background,
                automaticallyImplyLeading: false,
                clipBehavior: Clip.none,
                flexibleSpace: ClipRect(
                  clipBehavior: Clip.none,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CustomHomeAppBar(),
                      Positioned(
                        bottom: bottomPosition,
                        left: 16.w,
                        right: 16.w,
                        child: showProgressCard
                            ? ProgressCard(
                                enrollment: state.myCourses!.results.first,
                              )
                            : const TopHomeSection(),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: spacingHeight),
              ),
              const SliverToBoxAdapter(
                child: HomeBannersWidget(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 48.h),
              ),
              SliverToBoxAdapter(
                child: SeeAllSeperator(
                  onTap: () {
                    // Navigate to courses tab (index 2) in bottom navigation
                    final mainHomePageState =
                        context.findAncestorStateOfType<MainHomePageState>();
                    if (mainHomePageState != null) {
                      mainHomePageState.changeTab(2);
                    }
                  },
                  title: 'recommended_courses'.tr(),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppPadding.appPadding.copyWith(end: 0),
                  child: BlocBuilder<CourseCubit, CourseState>(
                    builder: (context, state) {
                      final categories = state.categories ?? [];
                      final labels =
                          ['all'.tr()] + categories.map((c) => c.name).toList();

                      return Skeletonizer(
                        enabled: state.categoriesStatus ==
                            ResponseStatusEnum.loading,
                        child: ChipsBar(
                          labels: labels,
                          onChipSelected: (value) {
                            final courseCubit = context.read<CourseCubit>();
                            if (value == 'all'.tr()) {
                              // Show all courses - filter locally (no API call)
                              courseCubit.filterCoursesLocallyByCategory(null);
                            } else {
                              // Find category by name and filter locally
                              if (categories.isNotEmpty) {
                                final category = categories.firstWhere(
                                  (c) => c.name == value,
                                  orElse: () => categories.first,
                                );
                                // Filter locally instead of making API call
                                courseCubit.filterCoursesLocallyByCategory(
                                    category.id);
                              }
                            }
                          },
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
                  padding: AppPadding.appPadding.copyWith(end: 0),
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
                  onTap: () {
                    context.push(RouteNames.viewAllArticles);
                  },
                  title: 'news_and_articles'.tr(),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 36),
              ),
              const ArticlesSection(),
              SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              ),
            ],
          );
        },
      ),
    );
  }
}
