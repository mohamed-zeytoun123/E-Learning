import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Article/data/models/article_model/article_model.dart';

class ArticleState {
  //?---------------------------------------------------------------

  //* Get Articles
  final List<ArticleModel>? articles;
  final List<ArticleModel>?
      allArticles; // Store all articles for local filtering
  final ResponseStatusEnum articlesStatus;
  final String? articlesError;

  //* Article Details
  final ArticleModel? articleDetails;
  final ResponseStatusEnum articleDetailsStatus;
  final String? articleDetailsError;

  //* Related Articles
  final List<ArticleModel>? relatedArticles;
  final ResponseStatusEnum relatedArticlesStatus;
  final String? relatedArticlesError;

  //* Pagination Info
  final int? currentPage;
  final int? totalPages;
  final int? count;
  final bool hasNextPage;
  final bool hasPreviousPage;

  //* Filters
  final int? currentUniversityId;
  final int? currentCollegeId;
  final int? currentStudyYear;

  //?----------------------------------------------------------------
  ArticleState({
    //* Get Articles
    this.articles,
    this.allArticles,
    this.articlesStatus = ResponseStatusEnum.initial,
    this.articlesError,

    //* Article Details
    this.articleDetails,
    this.articleDetailsStatus = ResponseStatusEnum.initial,
    this.articleDetailsError,

    //* Related Articles
    this.relatedArticles,
    this.relatedArticlesStatus = ResponseStatusEnum.initial,
    this.relatedArticlesError,

    //* Pagination Info
    this.currentPage,
    this.totalPages,
    this.count,
    this.hasNextPage = false,
    this.hasPreviousPage = false,

    //* Filters
    this.currentUniversityId,
    this.currentCollegeId,
    this.currentStudyYear,
  });

  //?------------------------------------------------------------------

  ArticleState copyWith({
    //* Get Articles
    List<ArticleModel>? articles,
    List<ArticleModel>? allArticles,
    ResponseStatusEnum? articlesStatus,
    String? articlesError,

    //* Article Details
    ArticleModel? articleDetails,
    ResponseStatusEnum? articleDetailsStatus,
    String? articleDetailsError,

    //* Related Articles
    List<ArticleModel>? relatedArticles,
    ResponseStatusEnum? relatedArticlesStatus,
    String? relatedArticlesError,

    //* Pagination Info
    int? currentPage,
    int? totalPages,
    int? count,
    bool? hasNextPage,
    bool? hasPreviousPage,

    //* Filters
    int? currentUniversityId,
    int? currentCollegeId,
    int? currentStudyYear,
  }) {
    return ArticleState(
      //* Get Articles
      articles: articles ?? this.articles,
      allArticles: allArticles ?? this.allArticles,
      articlesStatus: articlesStatus ?? this.articlesStatus,
      articlesError: articlesError ?? this.articlesError,

      //* Article Details
      articleDetails: articleDetails ?? this.articleDetails,
      articleDetailsStatus: articleDetailsStatus ?? this.articleDetailsStatus,
      articleDetailsError: articleDetailsError ?? this.articleDetailsError,

      //* Related Articles
      relatedArticles: relatedArticles ?? this.relatedArticles,
      relatedArticlesStatus:
          relatedArticlesStatus ?? this.relatedArticlesStatus,
      relatedArticlesError: relatedArticlesError ?? this.relatedArticlesError,

      //* Pagination Info
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      count: count ?? this.count,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,

      //* Filters
      currentUniversityId: currentUniversityId ?? this.currentUniversityId,
      currentCollegeId: currentCollegeId ?? this.currentCollegeId,
      currentStudyYear: currentStudyYear ?? this.currentStudyYear,
    );
  }

  //?-------------------------------------------------
}
