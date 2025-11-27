import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';

class PaginatedCoursesModel {
  final int? count;
  final String? next;
  final String? previous;
  final int? totalPages;
  final int? currentPage;
  final int? pageSize;
  final List<CourseModel>? results;

  PaginatedCoursesModel({
    this.count,
    this.next,
    this.previous,
    this.totalPages,
    this.currentPage,
    this.pageSize,
    this.results,
  });

  factory PaginatedCoursesModel.fromMap(Map<String, dynamic> map) {
    return PaginatedCoursesModel(
      count: map['count'] != null ? map['count'] as int : null,
      next: map['next'] as String?,
      previous: map['previous'] as String?,
      totalPages: map['total_pages'] != null ? map['total_pages'] as int : null,
      currentPage: map['current_page'] != null ? map['current_page'] as int : null,
      pageSize: map['page_size'] != null ? map['page_size'] as int : null,
      results: map['results'] != null
          ? List<CourseModel>.from(
              (map['results'] as List).map((e) => CourseModel.fromMap(e)),
            )
          : null,
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
      'results': results?.map((e) => e.toMap()).toList(),
    };
  }

  PaginatedCoursesModel copyWith({
    int? count,
    String? next,
    String? previous,
    int? totalPages,
    int? currentPage,
    int? pageSize,
    List<CourseModel>? results,
  }) {
    return PaginatedCoursesModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      results: results ?? this.results,
    );
  }
}
