import 'package:e_learning/features/Course/data/models/rating_result/rating_model.dart';

class PaginatedRatingsModel {
  final int count;
  final String? next;
  final String? previous;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<RatingModel> results;

  PaginatedRatingsModel({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory PaginatedRatingsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedRatingsModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      pageSize: json['page_size'],
      results: (json['results'] as List)
          .map((e) => RatingModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'total_pages': totalPages,
      'current_page': currentPage,
      'page_size': pageSize,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}
