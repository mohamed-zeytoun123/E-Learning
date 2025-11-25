import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attachment_model.g.dart';

@JsonSerializable()
class AttachmentModel {
  @IntConverter()
  final int id;
  
  @JsonKey(name: 'file_name')
  @StringConverter()
  final String fileName;
  
  @StringConverter()
  final String extension;
  
  @JsonKey(name: 'file_size_mb')
  @StringConverter()
  final String fileSizeMb;
  
  @NullableStringConverter()
  final String? description;
  
  @NullableStringConverter()
  final String? tag;
  
  @JsonKey(name: 'uploaded_at')
  @StringConverter()
  final String uploadedAt;
  
  @JsonKey(name: 'file_url')
  @StringConverter()
  final String fileUrl;
  
  AttachmentModel({
    required this.id,
    required this.fileName,
    required this.extension,
    required this.fileSizeMb,
    required this.description,
    required this.tag,
    required this.uploadedAt,
    required this.fileUrl,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);

  // Keep fromMap for backward compatibility
  factory AttachmentModel.fromMap(Map<String, dynamic> map) =>
      AttachmentModel.fromJson(map);
}
