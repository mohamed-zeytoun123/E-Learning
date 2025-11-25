// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizDetailsModel _$QuizDetailsModelFromJson(Map json) => QuizDetailsModel(
      id: const IntConverter().fromJson(json['id']),
      title: const StringConverter().fromJson(json['title']),
      description: const StringConverter().fromJson(json['description']),
      chapterTitle: const StringConverter().fromJson(json['chapter_title']),
      courseTitle: const StringConverter().fromJson(json['course_title']),
      totalPoints: const IntConverter().fromJson(json['total_points']),
      passingScore: const StringConverter().fromJson(json['passing_score']),
      durationMinutes: const IntConverter().fromJson(json['duration_minutes']),
      questionsCount: const IntConverter().fromJson(json['questions_count']),
      maxAttempts: const IntConverter().fromJson(json['max_attempts']),
      hasAttempted: const BoolConverter().fromJson(json['has_attempted']),
      createdAt: const StringConverter().fromJson(json['created_at']),
      attemptId: const IntConverter().fromJson(json['attempt_id']),
      attemptStatus:
          const NullableStringConverter().fromJson(json['attempt_status']),
    );

Map<String, dynamic> _$QuizDetailsModelToJson(QuizDetailsModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'title': const StringConverter().toJson(instance.title),
      'description': const StringConverter().toJson(instance.description),
      'chapter_title': const StringConverter().toJson(instance.chapterTitle),
      'course_title': const StringConverter().toJson(instance.courseTitle),
      'total_points': const IntConverter().toJson(instance.totalPoints),
      'passing_score': const StringConverter().toJson(instance.passingScore),
      'duration_minutes': const IntConverter().toJson(instance.durationMinutes),
      'questions_count': const IntConverter().toJson(instance.questionsCount),
      'max_attempts': const IntConverter().toJson(instance.maxAttempts),
      'has_attempted': const BoolConverter().toJson(instance.hasAttempted),
      'created_at': const StringConverter().toJson(instance.createdAt),
      'attempt_id': _$JsonConverterToJson<dynamic, int>(
          instance.attemptId, const IntConverter().toJson),
      'attempt_status':
          const NullableStringConverter().toJson(instance.attemptStatus),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
