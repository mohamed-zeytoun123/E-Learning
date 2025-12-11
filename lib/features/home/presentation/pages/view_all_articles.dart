import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/core/widgets/custom_error_widget.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/Article/presentation/manager/article_state.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/home/presentation/widgets/articles_section.dart';
import 'package:e_learning/features/home/presentation/widgets/filtered_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ViewAllArticles extends StatefulWidget {
  const ViewAllArticles({super.key});

  @override
  State<ViewAllArticles> createState() => _ViewAllArticlesState();
}

class _ViewAllArticlesState extends State<ViewAllArticles> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.85) {
      final cubit = context.read<ArticleCubit>();
      final state = cubit.state;

      // Only load more if there's a next page and not already loading
      if (state.hasNextPage &&
          state.articlesStatus != ResponseStatusEnum.loading) {
        cubit.loadMoreArticles();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticleCubit(repo: appLocator<ArticleRepository>())
            ..getArticles(page: 1, pageSize: 10),
        ),
        BlocProvider(
          create: (context) => CourseCubit(
            repo: appLocator<CourceseRepository>(),
            authRepo: appLocator<AuthRepository>(),
          )
            ..getCategories()
            ..getColleges(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("news".tr()),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: AppPadding.appPadding.copyWith(end: 0),
              child: BlocBuilder<CourseCubit, CourseState>(
                builder: (context, courseState) {
                  final categories = courseState.categories ?? [];
                  final labels = [
                    "all".tr(),
                    ...categories.map((c) => c.name).toList(),
                  ];

                  return ChipsBar(
                    labels: labels,
                    onChipSelected: (value) {
                      final articleCubit = context.read<ArticleCubit>();
                      if (value == "all".tr()) {
                        articleCubit.getArticles(page: 1, pageSize: 10);
                      } else {
                        final category = categories.firstWhere(
                          (c) => c.name == value,
                          orElse: () => categories.first,
                        );
                        articleCubit.getArticles(
                          page: 1,
                          pageSize: 10,
                          categoryId: category.id,
                        );
                      }
                    },
                    withFilter: true,
                    onFilterTap: () {
                      final courseCubit = context.read<CourseCubit>();
                      showFilterBottomSheet(
                        context,
                        courseCubit: courseCubit,
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 50.h),
            Expanded(
              child: BlocBuilder<ArticleCubit, ArticleState>(
                builder: (context, state) {
                  if (state.articlesStatus == ResponseStatusEnum.failure) {
                    return const CustomErrorWidget();
                  }

                  if (state.articles == null || state.articles!.isEmpty) {
                    if (state.articlesStatus == ResponseStatusEnum.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(
                      child: Text(
                        'no_articles_available'.tr(),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    );
                  }

                  return CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      const ArticlesSection(),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
