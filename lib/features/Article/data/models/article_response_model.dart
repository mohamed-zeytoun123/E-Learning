import 'package:e_learning/features/Article/data/models/article_model/article_model.dart';

class ArticleResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<ArticleModel> results;

  ArticleResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory ArticleResponseModel.fromMap(Map<String, dynamic> map) {
    final List<ArticleModel> resultsList = [];
    if (map['results'] != null && map['results'] is List) {
      for (var article in map['results']) {
        if (article is Map<String, dynamic>) {
          resultsList.add(ArticleModel.fromMap(article));
        }
      }
    }

    return ArticleResponseModel(
      count: map['count'] ?? 0,
      next: map['next'] as String?,
      previous: map['previous'] as String?,
      totalPages: map['total_pages'] ?? 1,
      currentPage: map['current_page'] ?? 1,
      pageSize: map['page_size'] ?? 10,
      results: resultsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'total_pages': totalPages,
      'current_page': currentPage,
      'page_size': pageSize,
      'results': results.map((article) => article.toMap()).toList(),
    };
  }
}




