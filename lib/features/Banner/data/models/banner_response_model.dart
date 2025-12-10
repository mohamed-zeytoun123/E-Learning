import 'package:e_learning/features/Banner/data/models/banner_model/banner_model.dart';

class BannerResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<BannerModel> results;

  BannerResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) {
    return BannerResponseModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      totalPages: json['total_pages'] ?? 1,
      currentPage: json['current_page'] ?? 1,
      pageSize: json['page_size'] ?? 10,
      results: (json['results'] as List<dynamic>?)
              ?.map((item) => BannerModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
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
      'results': results.map((item) => item.toJson()).toList(),
    };
  }
}

