// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterModel _$ChapterModelFromJson(Map json) => ChapterModel(
      id: const IntConverter().fromJson(json['id']),
      course: const IntConverter().fromJson(json['course']),
      title: const StringConverter().fromJson(json['title']),
      description: const StringConverter().fromJson(json['description']),
      attachmentsCount:
          const IntConverter().fromJson(json['attachments_count']),
      videosCount: const IntConverter().fromJson(json['videos_count']),
      createdAt: const DateTimeConverter().fromJson(json['created_at']),
    );

Map<String, dynamic> _$ChapterModelToJson(ChapterModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'course': const IntConverter().toJson(instance.course),
      'title': const StringConverter().toJson(instance.title),
      'description': const StringConverter().toJson(instance.description),
      'attachments_count':
          const IntConverter().toJson(instance.attachmentsCount),
      'videos_count': const IntConverter().toJson(instance.videosCount),
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
    };
