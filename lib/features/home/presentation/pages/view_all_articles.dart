import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/chips_bar.dart';
import 'package:e_learning/core/widgets/custom_error_widget.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';
import 'package:e_learning/features/Article/presentation/manager/article_cubit.dart';
import 'package:e_learning/features/Article/presentation/manager/article_state.dart';
import 'package:e_learning/features/home/presentation/widgets/articles_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ViewAllArticles extends StatelessWidget {
  const ViewAllArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ArticleCubit(repo: appLocator<ArticleRepository>())..getArticles(),
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
              child: ChipsBar(
                labels: [
                  "all".tr(),
                  "tips_and_skills".tr(),
                  "academic_guidance".tr(),
                  "carrer_and_skils".tr()
                ],
                onChipSelected: (value) {
                  // TODO: Implement category filtering
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
