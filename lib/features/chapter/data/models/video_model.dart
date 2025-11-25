import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  @IntConverter()
  final int id;
  
  @StringConverter()
  final String title;
  
  @IntConverter()
  final int duration;
  
  @StringConverter()
  final String format;
  
  @JsonKey(name: 'uploaded_at')
  @StringConverter()
  final String uploadedAt;
  
  @IntConverter()
  final int chapter;
  
  @JsonKey(name: 'storage_type')
  @StringConverter()
  final String storageType;
  
  @JsonKey(name: 'video_file')
  @NullableStringConverter()
  final String? videoFile;
  
  @JsonKey(name: 'video_guid')
  @StringConverter()
  final String videoGuid;
  
  @JsonKey(name: 'bunny_video_url')
  @StringConverter()
  final String bunnyVideoUrl;
  
  @StringConverter()
  final String description;
  
  @IntConverter()
  final int order;
  
  @NullableDoubleConverter()
  final double? progress;

  VideoModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.format,
    required this.uploadedAt,
    required this.chapter,
    required this.storageType,
    this.videoFile,
    required this.videoGuid,
    required this.bunnyVideoUrl,
    required this.description,
    required this.order,
    this.progress,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}

