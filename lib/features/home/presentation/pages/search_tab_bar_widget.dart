import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_cubit.dart';
import 'package:e_learning/features/home/presentation/pages/search_courses_tab_content.dart';
import 'package:e_learning/features/home/presentation/pages/search_teachers_tab_content.dart';
import 'package:e_learning/features/home/presentation/pages/search_articles_tab_content.dart';
import 'package:e_learning/features/Teacher/data/source/repo/teacher_repository.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTabBarWidget extends StatefulWidget {
  final SearchCubit searchCubit;
  
  const SearchTabBarWidget({
    super.key,
    required this.searchCubit,
  });

  @override
  State<SearchTabBarWidget> createState() => _SearchTabBarWidgetState();
}

class _SearchTabBarWidgetState extends State<SearchTabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CourseCubit>.value(
          value: CourseCubit(
            repo: appLocator<CourceseRepository>(),
          ),
        ),
        BlocProvider<TeacherCubit>(
          create: (context) => TeacherCubit(
            repo: appLocator<TeacherRepository>(),
          ),
        ),
        BlocProvider<ArticleCubit>(
          create: (context) => ArticleCubit(
            repo: appLocator<ArticleRepository>(),
          ),
        ),
      ],
      child: Column(
        children: [
          Container(
            color: AppColors.backgroundPage,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.textGrey,
              indicatorColor: AppColors.buttonPrimary,
              labelStyle: AppTextStyles.s16w600,
              unselectedLabelStyle: AppTextStyles.s16w400,
              tabs: [
                Tab(text: 'courses'.tr()),
                Tab(text: 'teachers'.tr()),
                Tab(text: 'articles'.tr()),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SearchCoursesTabContent(searchCubit: widget.searchCubit),
                SearchTeachersTabContent(searchCubit: widget.searchCubit),
                SearchArticlesTabContent(searchCubit: widget.searchCubit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

