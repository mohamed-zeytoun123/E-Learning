import 'package:hive/hive.dart';

part 'study_year_model.g.dart';

@HiveType(typeId: 5)
class StudyYearModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int yearNumber;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final bool isActive;

  StudyYearModel({
    required this.id,
    required this.yearNumber,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory StudyYearModel.fromJson(Map<String, dynamic> json) {
    return StudyYearModel(
      id: json['id'],
      yearNumber: json['year_number'],
      name: json['name'],
      description: json['description'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year_number': yearNumber,
      'name': name,
      'description': description,
      'is_active': isActive,
    };
  }
}

// موديل للصفحة الكاملة
@HiveType(typeId: 1)
class StudyYearResponse extends HiveObject {
  @HiveField(0)
  final int count;

  @HiveField(1)
  final int currentPage;

  @HiveField(2)
  final int pageSize;

  @HiveField(3)
  final List<StudyYearModel> results;

  StudyYearResponse({
    required this.count,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory StudyYearResponse.fromJson(Map<String, dynamic> json) {
    return StudyYearResponse(
      count: json['count'],
      currentPage: json['current_page'],
      pageSize: json['page_size'],
      results: (json['results'] as List)
          .map((e) => StudyYearModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'current_page': currentPage,
      'page_size': pageSize,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}
