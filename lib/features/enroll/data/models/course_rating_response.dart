class CourseRatingResponse {
  final int count;
  final String? next;
  final String? previous;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<CourseRatingItem> results;

  const CourseRatingResponse({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory CourseRatingResponse.fromJson(Map<String, dynamic> json) {
    return CourseRatingResponse(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      totalPages: json['total_pages'] as int,
      currentPage: json['current_page'] as int,
      pageSize: json['page_size'] as int,
      results: (json['results'] as List<dynamic>)
          .map(
            (item) => CourseRatingItem.fromJson(item as Map<String, dynamic>),
          )
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
      'results': results.map((item) => item.toJson()).toList(),
    };
  }

  CourseRatingResponse copyWith({
    int? count,
    String? next,
    String? previous,
    int? totalPages,
    int? currentPage,
    int? pageSize,
    List<CourseRatingItem>? results,
  }) {
    return CourseRatingResponse(
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

class CourseRatingItem {
  final int id;
  final String studentName;
  final int rating;
  final String comment;
  final bool isFeatured;
  final String createdAt;

  const CourseRatingItem({
    required this.id,
    required this.studentName,
    required this.rating,
    required this.comment,
    required this.isFeatured,
    required this.createdAt,
  });

  factory CourseRatingItem.fromJson(Map<String, dynamic> json) {
    return CourseRatingItem(
      id: json['id'] as int,
      studentName: json['student_name'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      isFeatured: json['is_featured'] as bool,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_name': studentName,
      'rating': rating,
      'comment': comment,
      'is_featured': isFeatured,
      'created_at': createdAt,
    };
  }

  CourseRatingItem copyWith({
    int? id,
    String? studentName,
    int? rating,
    String? comment,
    bool? isFeatured,
    String? createdAt,
  }) {
    return CourseRatingItem(
      id: id ?? this.id,
      studentName: studentName ?? this.studentName,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
