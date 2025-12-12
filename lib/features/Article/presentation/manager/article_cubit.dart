import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
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
    int? universityId,
    int? collegeId,
    int? studyYear,
  }) async {
    // If page is 1 or null, clear articles (new filter or initial load)
    // If page > 1, keep articles (pagination)
    final shouldClearArticles = page == null || page == 1;
    emit(state.copyWith(
      articlesStatus: ResponseStatusEnum.loading,
      articles: shouldClearArticles ? [] : state.articles,
    ));

    final result = await repo.getArticlesRepo(
      page: page,
      pageSize: pageSize,
      search: search,
      categoryId: categoryId,
      universityId: universityId,
      collegeId: collegeId,
      studyYear: studyYear,
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

        // Store all articles when fetching without category filter (for local filtering)
        final shouldStoreAllArticles =
            categoryId == null && (page == null || page == 1);
        final allArticlesToStore = shouldStoreAllArticles
            ? articleResponse.results
            : state.allArticles;

        final newState = state.copyWith(
          articlesStatus: ResponseStatusEnum.success,
          articles: articleResponse.results,
          allArticles:
              allArticlesToStore, // Store all articles for local filtering
          articlesError: null,
          currentPage: articleResponse.currentPage,
          totalPages: articleResponse.totalPages,
          count: articleResponse.count,
          hasNextPage: articleResponse.next != null,
          hasPreviousPage: articleResponse.previous != null,
          currentUniversityId: universityId,
          currentCollegeId: collegeId,
          currentStudyYear: studyYear,
        );
        emit(newState);
      },
    );
  }

  //?-------------------------------------------------

  //* Load More Articles (Next Page)
  Future<void> loadMoreArticles() async {
    if (!state.hasNextPage ||
        state.articlesStatus == ResponseStatusEnum.loading) {
      return;
    }

    final nextPage = (state.currentPage ?? 1) + 1;
    emit(state.copyWith(articlesStatus: ResponseStatusEnum.loading));

    final result = await repo.getArticlesRepo(
      page: nextPage,
      universityId: state.currentUniversityId,
      collegeId: state.currentCollegeId,
      studyYear: state.currentStudyYear,
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

        // Append to allArticles if we're not filtering by category (for local filtering)
        final currentAllArticles = state.allArticles ?? [];
        final updatedAllArticles = [
          ...currentAllArticles,
          ...articleResponse.results
        ];

        final newState = state.copyWith(
          articlesStatus: ResponseStatusEnum.success,
          articles: newArticles,
          allArticles:
              updatedAllArticles, // Append to all articles for local filtering
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
  //* Filter Articles Locally by Category (for articles page)
  //* This filters already-fetched articles locally without making a new API call
  void filterArticlesLocallyByCategory(int? categoryId) {
    try {
      // Get all articles (stored when fetching without category filter)
      final allArticlesList = state.allArticles ?? state.articles ?? [];

      if (categoryId == null) {
        // Show all articles - restore original articles
        if (state.allArticles != null) {
          emit(state.copyWith(
            articles: state.allArticles,
            currentPage: 1,
            hasNextPage: false, // Reset pagination when showing all
          ));
        } else {
          emit(state.copyWith(
            currentPage: 1,
            hasNextPage: false,
          ));
        }
        return;
      }

      // Filter articles locally by category
      final filteredArticles = allArticlesList.where((article) {
        return article.category == categoryId;
      }).toList();

      emit(state.copyWith(
        articles: filteredArticles,
        currentPage: 1,
        hasNextPage: false, // Reset pagination when filtering locally
      ));
    } catch (e) {
      print('Error in filterArticlesLocallyByCategory: $e');
    }
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
