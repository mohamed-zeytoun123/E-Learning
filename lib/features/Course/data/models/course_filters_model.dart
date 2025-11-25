import 'package:e_learning/core/utils/json_converters.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_filters_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class CourseFiltersModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'college_id')
  @IntConverter()
  final int? collegeId;

  @HiveField(1)
  @JsonKey(name: 'study_year')
  @IntConverter()
  final int? studyYear;

  @HiveField(2)
  @JsonKey(name: 'category_id')
  @IntConverter()
  final int? categoryId;

  CourseFiltersModel({this.collegeId, this.studyYear, this.categoryId});

  factory CourseFiltersModel.fromJson(Map<String, dynamic> json) =>
      _$CourseFiltersModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseFiltersModelToJson(this);
}

