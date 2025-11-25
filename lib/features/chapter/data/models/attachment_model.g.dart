// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentModel _$AttachmentModelFromJson(Map json) => AttachmentModel(
      id: const IntConverter().fromJson(json['id']),
      fileName: const StringConverter().fromJson(json['file_name']),
      extension: const StringConverter().fromJson(json['extension']),
      fileSizeMb: const StringConverter().fromJson(json['file_size_mb']),
      description:
          const NullableStringConverter().fromJson(json['description']),
      tag: const NullableStringConverter().fromJson(json['tag']),
      uploadedAt: const StringConverter().fromJson(json['uploaded_at']),
      fileUrl: const StringConverter().fromJson(json['file_url']),
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'file_name': const StringConverter().toJson(instance.fileName),
      'extension': const StringConverter().toJson(instance.extension),
      'file_size_mb': const StringConverter().toJson(instance.fileSizeMb),
      'description':
          const NullableStringConverter().toJson(instance.description),
      'tag': const NullableStringConverter().toJson(instance.tag),
      'uploaded_at': const StringConverter().toJson(instance.uploadedAt),
      'file_url': const StringConverter().toJson(instance.fileUrl),
    };
