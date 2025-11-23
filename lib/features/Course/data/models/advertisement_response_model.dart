import 'package:e_learning/features/Course/data/models/advertisment_model.dart';

class AdvertisementResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<AdvertisementModel> results;

  AdvertisementResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory AdvertisementResponseModel.fromMap(Map<String, dynamic> map) {
    final List<AdvertisementModel> resultsList = [];
    if (map['results'] != null && map['results'] is List) {
      for (var advertisement in map['results']) {
        if (advertisement is Map<String, dynamic>) {
          resultsList.add(AdvertisementModel.fromMap(advertisement));
        }
      }
    }

    return AdvertisementResponseModel(
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
      'results': results.map((advertisement) => advertisement.toMap()).toList(),
    };
  }
}

