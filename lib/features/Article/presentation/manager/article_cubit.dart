import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';
import 'package:e_learning/features/Article/presentation/manager/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit({required this.repo}) : super(ArticleState());
  final ArticleRepository repo;

  //?-------------------------------------------------

  //* Get Articles
  Future<void> getArticles({
    int? page,
    int? pageSize,
    String? search,
    int? categoryId,
  }) async {
    emit(state.copyWith(articlesStatus: ResponseStatusEnum.loading));

    final result = await repo.getArticlesRepo(
      page: page,
      pageSize: pageSize,
      search: search,
      categoryId: categoryId,
    );

    result.fold(
      (failure) {
        print('❌ ArticleCubit: Failed to get articles - ${failure.message}');
        emit(
          state.copyWith(
            articlesStatus: ResponseStatusEnum.failure,
            articlesError: failure.message,
          ),
        );
      },
      (articleResponse) {
        print(
            '✅ ArticleCubit: Successfully loaded ${articleResponse.results.length} articles');
        final newState = state.copyWith(
          articlesStatus: ResponseStatusEnum.success,
          articles: articleResponse.results,
          articlesError: null,
          currentPage: articleResponse.currentPage,
          totalPages: articleResponse.totalPages,
          count: articleResponse.count,
          hasNextPage: articleResponse.next != null,
          hasPreviousPage: articleResponse.previous != null,
        );
        emit(newState);
      },
    );
  }

  //?-------------------------------------------------

  //* Load More Articles (Next Page)
  Future<void> loadMoreArticles({int? categoryId}) async {
    if (!state.hasNextPage ||
        state.articlesStatus == ResponseStatusEnum.loading) {
      return;
    }

    final nextPage = (state.currentPage ?? 1) + 1;
    emit(state.copyWith(articlesStatus: ResponseStatusEnum.loading));

    final result = await repo.getArticlesRepo(
      page: nextPage,
      categoryId: categoryId,
    );

    result.fold(
      (failure) {
        print(
            '❌ ArticleCubit: Failed to load more articles - ${failure.message}');
        emit(
          state.copyWith(
            articlesStatus: ResponseStatusEnum.failure,
            articlesError: failure.message,
          ),
        );
      },
      (articleResponse) {
        final currentArticles = state.articles ?? [];
        final newArticles = [...currentArticles, ...articleResponse.results];
        print(
            '✅ ArticleCubit: Loaded ${articleResponse.results.length} more articles. Total: ${newArticles.length}');
        final newState = state.copyWith(
          articlesStatus: ResponseStatusEnum.success,
          articles: newArticles,
          articlesError: null,
          currentPage: articleResponse.currentPage,
          totalPages: articleResponse.totalPages,
          count: articleResponse.count,
          hasNextPage: articleResponse.next != null,
          hasPreviousPage: articleResponse.previous != null,
        );
        emit(newState);
      },
    );
  }

  //?-------------------------------------------------

  //* Refresh Articles
  Future<void> refreshArticles({String? search, int? categoryId}) async {
    emit(state.copyWith(articlesStatus: ResponseStatusEnum.loading));

    final result = await repo.getArticlesRepo(
      search: search,
      categoryId: categoryId,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            articlesStatus: ResponseStatusEnum.failure,
            articlesError: failure.message,
          ),
        );
      },
      (articleResponse) {
        final newState = state.copyWith(
          articlesStatus: ResponseStatusEnum.success,
          articles: articleResponse.results,
          articlesError: null,
          currentPage: articleResponse.currentPage,
          totalPages: articleResponse.totalPages,
          count: articleResponse.count,
          hasNextPage: articleResponse.next != null,
          hasPreviousPage: articleResponse.previous != null,
        );
        emit(newState);
      },
    );
  }

  //?-------------------------------------------------

  //* Get Article Details by ID
  Future<void> getArticleDetails({required int articleId}) async {
    emit(state.copyWith(articleDetailsStatus: ResponseStatusEnum.loading));

    final result = await repo.getArticleDetailsRepo(
      articleId: articleId,
    );

    result.fold(
      (failure) {
        print(
            '❌ ArticleCubit: Failed to get article details - ${failure.message}');
        emit(
          state.copyWith(
            articleDetailsStatus: ResponseStatusEnum.failure,
            articleDetailsError: failure.message,
          ),
        );
      },
      (articleDetails) {
        print(
            '✅ ArticleCubit: Successfully loaded article details: ${articleDetails.title}');
        emit(
          state.copyWith(
            articleDetailsStatus: ResponseStatusEnum.success,
            articleDetails: articleDetails,
            articleDetailsError: null,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------

  //* Get Related Articles by Article ID
  Future<void> getRelatedArticles({required int articleId}) async {
    emit(state.copyWith(relatedArticlesStatus: ResponseStatusEnum.loading));

    final result = await repo.getRelatedArticlesRepo(
      articleId: articleId,
    );

    result.fold(
      (failure) {
        print(
            '❌ ArticleCubit: Failed to get related articles - ${failure.message}');
        emit(
          state.copyWith(
            relatedArticlesStatus: ResponseStatusEnum.failure,
            relatedArticlesError: failure.message,
          ),
        );
      },
      (relatedArticlesResponse) {
        print(
            '✅ ArticleCubit: Successfully loaded ${relatedArticlesResponse.results.length} related articles');
        emit(
          state.copyWith(
            relatedArticlesStatus: ResponseStatusEnum.success,
            relatedArticles: relatedArticlesResponse.results,
            relatedArticlesError: null,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------
}
