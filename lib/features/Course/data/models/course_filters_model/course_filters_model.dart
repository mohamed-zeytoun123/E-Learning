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

  CourseFiltersModel({this.collegeId, this.studyYear, this.categoryId});
}
