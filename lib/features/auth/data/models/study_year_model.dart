import 'package:e_learning/core/utils/json_converters.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'study_year_model.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class StudyYearModel extends HiveObject {
  @HiveField(0)
  @IntConverter()
  final int id;

  @HiveField(1)
  @JsonKey(name: 'year_number')
  @IntConverter()
  final int yearNumber;

  @HiveField(2)
  @StringConverter()
  final String name;

  @HiveField(3)
  @StringConverter()
  final String description;

  @HiveField(4)
  @JsonKey(name: 'is_active')
  @BoolConverter()
  final bool isActive;

  StudyYearModel({
    required this.id,
    required this.yearNumber,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory StudyYearModel.fromJson(Map<String, dynamic> json) =>
      _$StudyYearModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudyYearModelToJson(this);
}

// موديل للصفحة الكاملة
@HiveType(typeId: 1)
@JsonSerializable()
class StudyYearResponse extends HiveObject {
  @HiveField(0)
  @IntConverter()
  final int count;

  @HiveField(1)
  @JsonKey(name: 'current_page')
  @IntConverter()
  final int currentPage;

  @HiveField(2)
  @JsonKey(name: 'page_size')
  @IntConverter()
  final int pageSize;

  @HiveField(3)
  final List<StudyYearModel> results;

  StudyYearResponse({
    required this.count,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory StudyYearResponse.fromJson(Map<String, dynamic> json) =>
      _$StudyYearResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StudyYearResponseToJson(this);
}
