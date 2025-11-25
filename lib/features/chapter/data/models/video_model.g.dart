// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map json) => VideoModel(
      id: const IntConverter().fromJson(json['id']),
      title: const StringConverter().fromJson(json['title']),
      duration: const IntConverter().fromJson(json['duration']),
      format: const StringConverter().fromJson(json['format']),
      uploadedAt: const StringConverter().fromJson(json['uploaded_at']),
      chapter: const IntConverter().fromJson(json['chapter']),
      storageType: const StringConverter().fromJson(json['storage_type']),
      videoFile: const NullableStringConverter().fromJson(json['video_file']),
      videoGuid: const StringConverter().fromJson(json['video_guid']),
      bunnyVideoUrl: const StringConverter().fromJson(json['bunny_video_url']),
      description: const StringConverter().fromJson(json['description']),
      order: const IntConverter().fromJson(json['order']),
      progress: const NullableDoubleConverter().fromJson(json['progress']),
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'title': const StringConverter().toJson(instance.title),
      'duration': const IntConverter().toJson(instance.duration),
      'format': const StringConverter().toJson(instance.format),
      'uploaded_at': const StringConverter().toJson(instance.uploadedAt),
      'chapter': const IntConverter().toJson(instance.chapter),
      'storage_type': const StringConverter().toJson(instance.storageType),
      'video_file': const NullableStringConverter().toJson(instance.videoFile),
      'video_guid': const StringConverter().toJson(instance.videoGuid),
      'bunny_video_url': const StringConverter().toJson(instance.bunnyVideoUrl),
      'description': const StringConverter().toJson(instance.description),
      'order': const IntConverter().toJson(instance.order),
      'progress': const NullableDoubleConverter().toJson(instance.progress),
    };
