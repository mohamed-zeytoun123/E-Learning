import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/widgets/courses_tab_content.dart';
import 'package:e_learning/features/Course/presentation/widgets/teachers_tab_content.dart';
import 'package:e_learning/features/Course/presentation/widgets/articles_tab_content.dart';
import 'package:e_learning/features/Teacher/data/source/repo/teacher_repository.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesTabBarWidget extends StatefulWidget {
  const CoursesTabBarWidget({super.key});

  @override
  State<CoursesTabBarWidget> createState() => _CoursesTabBarWidgetState();
}

class _CoursesTabBarWidgetState extends State<CoursesTabBarWidget>
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
        BlocProvider<CourseCubit>(
          create: (context) => CourseCubit(
            repo: di<CourceseRepository>(),
          )..getCourses(page: 1, pageSize: 10),
        ),
        BlocProvider<TeacherCubit>(
          create: (context) => TeacherCubit(
            repo: di<TeacherRepository>(),
          )..getTeachers(page: 1, pageSize: 10),
        ),
        BlocProvider<ArticleCubit>(
          create: (context) => ArticleCubit(
            repo: di<ArticleRepository>(),
          )..getArticles(page: 1, pageSize: 10),
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
              children: const [
                CoursesTabContent(),
                TeachersTabContent(),
                ArticlesTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

