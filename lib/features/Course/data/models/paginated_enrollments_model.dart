import 'package:e_learning/features/Course/data/models/enrollment_model.dart';

class PaginatedEnrollmentsModel {
  final int count;
  final String? next;
  final String? previous;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<EnrollmentModel> results;

  PaginatedEnrollmentsModel({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory PaginatedEnrollmentsModel.fromMap(Map<String, dynamic> map) {
    return PaginatedEnrollmentsModel(
      count: map['count'] as int? ?? 0,
      next: map['next'] as String?,
      previous: map['previous'] as String?,
      totalPages: map['total_pages'] as int? ?? 1,
      currentPage: map['current_page'] as int? ?? 1,
      pageSize: map['page_size'] as int? ?? 1,
      results: (map['results'] as List<dynamic>?)
              ?.map((item) => EnrollmentModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  bool get hasNextPage => next != null && next!.isNotEmpty;
}

