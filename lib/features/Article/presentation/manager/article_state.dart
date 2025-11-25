import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/Article/data/models/article_model.dart';

class ArticleState {
  //?---------------------------------------------------------------

  //* Get Articles
  final List<ArticleModel>? articles;
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

  //?----------------------------------------------------------------
  ArticleState({
    //* Get Articles
    this.articles,
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
  });

  //?------------------------------------------------------------------

  ArticleState copyWith({
    //* Get Articles
    List<ArticleModel>? articles,
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
  }) {
    return ArticleState(
      //* Get Articles
      articles: articles ?? this.articles,
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
    );
  }

  //?-------------------------------------------------
}
