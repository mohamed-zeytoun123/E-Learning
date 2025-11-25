import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chapter_model.g.dart';

@JsonSerializable()
class ChapterModel {
  @IntConverter()
  final int id;
  
  @IntConverter()
  final int course;
  
  @StringConverter()
  final String title;
  
  @StringConverter()
  final String description;
  
  @JsonKey(name: 'attachments_count')
  @IntConverter()
  final int attachmentsCount;
  
  @JsonKey(name: 'videos_count')
  @IntConverter()
  final int videosCount;
  
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  final DateTime createdAt;

  ChapterModel({
    required this.id,
    required this.course,
    required this.title,
    required this.description,
    required this.attachmentsCount,
    required this.videosCount,
    required this.createdAt,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory ChapterModel.fromMap(Map<String, dynamic> map) =>
      ChapterModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}

