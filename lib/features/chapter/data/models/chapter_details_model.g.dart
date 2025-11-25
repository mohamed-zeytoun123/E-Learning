// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterDetailsModel _$ChapterDetailsModelFromJson(Map json) =>
    ChapterDetailsModel(
      id: const IntConverter().fromJson(json['id']),
      course: const IntConverter().fromJson(json['course']),
      courseTitle: const StringConverter().fromJson(json['course_title']),
      title: const StringConverter().fromJson(json['title']),
      description: const StringConverter().fromJson(json['description']),
      createdAt: const DateTimeConverter().fromJson(json['created_at']),
    );

Map<String, dynamic> _$ChapterDetailsModelToJson(
        ChapterDetailsModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'course': const IntConverter().toJson(instance.course),
      'course_title': const StringConverter().toJson(instance.courseTitle),
      'title': const StringConverter().toJson(instance.title),
      'description': const StringConverter().toJson(instance.description),
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
    };
