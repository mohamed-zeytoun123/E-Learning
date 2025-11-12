import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_cubit.dart';
import 'package:e_learning/features/Teacher/data/source/repo/teacher_repository.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';
import 'package:e_learning/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CourseCubit(repo: appLocator<CourceseRepository>())
                ..getCategories()
                ..getCourses(),
        ),
        BlocProvider(
          create: (context) =>
              TeacherCubit(repo: appLocator<TeacherRepository>())
                ..getTeachers(),
        ),
        BlocProvider(
          create: (context) =>
              ArticleCubit(repo: appLocator<ArticleRepository>())
                ..getArticles(),
        ),
      ],
      child: const HomePage(),
    );
  }
}
