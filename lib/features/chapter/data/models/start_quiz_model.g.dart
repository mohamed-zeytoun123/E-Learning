// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartQuizModel _$StartQuizModelFromJson(Map json) => StartQuizModel(
      id: const IntConverter().fromJson(json['id']),
      quiz: const IntConverter().fromJson(json['quiz']),
      quizTitle: const StringConverter().fromJson(json['quiz_title']),
      totalPoints: const IntConverter().fromJson(json['total_points']),
      durationMinutes: const IntConverter().fromJson(json['duration_minutes']),
      status: const StringConverter().fromJson(json['status']),
      startedAt: const DateTimeConverter().fromJson(json['started_at']),
      questions: (json['questions'] as List<dynamic>)
          .map((e) =>
              QuestionModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$StartQuizModelToJson(StartQuizModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'quiz': const IntConverter().toJson(instance.quiz),
      'quiz_title': const StringConverter().toJson(instance.quizTitle),
      'total_points': const IntConverter().toJson(instance.totalPoints),
      'duration_minutes': const IntConverter().toJson(instance.durationMinutes),
      'status': const StringConverter().toJson(instance.status),
      'started_at': const DateTimeConverter().toJson(instance.startedAt),
      'questions': instance.questions,
    };
