import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';

class TeacherResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final List<TeacherModel> results;

  TeacherResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory TeacherResponseModel.fromMap(Map<String, dynamic> map) {
    final List<TeacherModel> resultsList = [];
    if (map['results'] != null && map['results'] is List) {
      for (var teacher in map['results']) {
        if (teacher is Map<String, dynamic>) {
          resultsList.add(TeacherModel.fromMap(teacher));
        }
      }
    }

    return TeacherResponseModel(
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
      'results': results.map((teacher) => teacher.toMap()).toList(),
    };
  }
}

