import 'package:hive/hive.dart';

part 'course_filters_model.g.dart';

@HiveType(typeId: 6)
class CourseFiltersModel extends HiveObject {
  @HiveField(0)
  final int? collegeId;

  @HiveField(1)
  final int? studyYear;

  @HiveField(2)
  final int? categoryId;

  @HiveField(3)
  final int? universityId;

  CourseFiltersModel({
    this.collegeId,
    this.studyYear,
    this.categoryId,
    this.universityId,
  });

  CourseFiltersModel copyWith({
    int? collegeId,
    int? categoryId,
    int? studyYear,
    int? universityId,
  }) {
    return CourseFiltersModel(
      collegeId: collegeId ?? this.collegeId,
      categoryId: categoryId ?? this.categoryId,
      studyYear: studyYear ?? this.studyYear,
      universityId: universityId ?? this.universityId,
    );
  }
}
