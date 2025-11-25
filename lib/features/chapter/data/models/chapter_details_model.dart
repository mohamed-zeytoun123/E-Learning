import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chapter_details_model.g.dart';

@JsonSerializable()
class ChapterDetailsModel {
  @IntConverter()
  final int id;
  
  @IntConverter()
  final int course;
  
  @JsonKey(name: 'course_title')
  @StringConverter()
  final String courseTitle;
  
  @StringConverter()
  final String title;
  
  @StringConverter()
  final String description;
  
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  final DateTime createdAt;
  
  ChapterDetailsModel({
    required this.id,
    required this.course,
    required this.courseTitle,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory ChapterDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDetailsModelToJson(this);

  // Keep fromMap for backward compatibility
  factory ChapterDetailsModel.fromMap(Map<String, dynamic> map) =>
      ChapterDetailsModel.fromJson(map);

  ChapterDetailsModel copyWith({
    int? id,
    int? course,
    String? courseTitle,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return ChapterDetailsModel(
      id: id ?? this.id,
      course: course ?? this.course,
      courseTitle: courseTitle ?? this.courseTitle,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
