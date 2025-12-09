import 'package:e_learning/features/Course/data/models/course_model/course_model.dart' as base;

class PagCoursesResult {
  final List<base.CourseModel>? courses;
  final int? count;
  final String? next;
  final String? previous;
  final int? currentPage;
  final int? totalPages;

  PagCoursesResult({
    this.courses,
    this.count,
    this.next,
    this.previous,
    this.currentPage,
    this.totalPages,
  });

  factory PagCoursesResult.fromMap(Map<String, dynamic> map) {
    final results = map['results'] as List?;
    final courses = results
        ?.map((item) {
          try {
            return base.CourseModel.fromMap(item as Map<String, dynamic>);
          } catch (e) {
            return null;
          }
        })
        .whereType<base.CourseModel>()
        .toList();

    final count = map['count'] as int?;
    final pageSize = map['page_size'] as int? ?? 5;
    final currentPage = _extractPageFromUrl(map['next'] as String?) ??
        (_extractPageFromUrl(map['previous'] as String?) != null
            ? (_extractPageFromUrl(map['previous'] as String?)! + 1)
            : 1);

    return PagCoursesResult(
      courses: courses ?? [],
      count: count,
      next: map['next'] as String?,
      previous: map['previous'] as String?,
      currentPage: currentPage,
      totalPages: count != null && pageSize != 0
          ? (count / pageSize).ceil()
          : null,
    );
  }

  static int? _extractPageFromUrl(String? url) {
    if (url == null) return null;
    final uri = Uri.parse(url);
    final pageParam = uri.queryParameters['page'];
    return pageParam != null ? int.tryParse(pageParam) : null;
  }
}

