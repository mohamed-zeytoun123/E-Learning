import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.h,
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
                    bottom: -87.h,
                    left: 16.w,
                    right: 16.w,
                    child: const ProgressCard(progress: 0.7),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 130.h),
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
                context.push(RouteNames.viewAllCourses);
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
                    enabled:
                        state.categoriesStatus == ResponseStatusEnum.loading,
                    child: ChipsBar(
                      labels: labels,
                      onChipSelected: (value) {
                        final courseCubit = context.read<CourseCubit>();
                        if (value == 'all'.tr()) {
                          // Show all courses - clear filters
                          courseCubit.clearFiltersAndGetCourses();
                        } else {
                          // Find category by name and filter
                          if (categories.isNotEmpty) {
                            final category = categories.firstWhere(
                              (c) => c.name == value,
                              orElse: () => categories.first,
                            );
                            courseCubit.applyFiltersByIds(
                              categoryId: category.id,
                            );
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
              child: const CourseSlider(maxItems: 3),
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
              title: 'news_and_articles'.tr(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 36),
          ),
          const ArticlesSection(itemsForShow: 3),
          SliverToBoxAdapter(
            child: SizedBox(height: 24.h),
          ),
        ],
      ),
    );
  }
}
