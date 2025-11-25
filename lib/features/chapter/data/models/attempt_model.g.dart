// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttemptModel _$AttemptModelFromJson(Map json) => AttemptModel(
      id: const IntConverter().fromJson(json['id']),
      quiz: const IntConverter().fromJson(json['quiz']),
      quizTitle: const NullableStringConverter().fromJson(json['quizTitle']),
      quizDescription:
          const NullableStringConverter().fromJson(json['quizDescription']),
      status: const NullableStringConverter().fromJson(json['status']),
      score: const NullableStringConverter().fromJson(json['score']),
      totalPoints: const IntConverter().fromJson(json['total_points']),
      percentage: const NullableStringConverter().fromJson(json['percentage']),
      passingScore:
          const NullableStringConverter().fromJson(json['passingScore']),
      isPassed: const BoolConverter().fromJson(json['is_passed']),
      startedAt: const NullableStringConverter().fromJson(json['startedAt']),
      submittedAt:
          const NullableStringConverter().fromJson(json['submittedAt']),
      timeTakenSeconds:
          const IntConverter().fromJson(json['time_taken_seconds']),
      durationMinutes: const IntConverter().fromJson(json['duration_minutes']),
      timeRemainingSeconds:
          const IntConverter().fromJson(json['time_remaining_seconds']),
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) =>
              AnswerSubmitModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$AttemptModelToJson(AttemptModel instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<dynamic, int>(
          instance.id, const IntConverter().toJson),
      'quiz': _$JsonConverterToJson<dynamic, int>(
          instance.quiz, const IntConverter().toJson),
      'quizTitle': const NullableStringConverter().toJson(instance.quizTitle),
      'quizDescription':
          const NullableStringConverter().toJson(instance.quizDescription),
      'status': const NullableStringConverter().toJson(instance.status),
      'score': const NullableStringConverter().toJson(instance.score),
      'total_points': _$JsonConverterToJson<dynamic, int>(
          instance.totalPoints, const IntConverter().toJson),
      'percentage': const NullableStringConverter().toJson(instance.percentage),
      'passingScore':
          const NullableStringConverter().toJson(instance.passingScore),
      'is_passed': _$JsonConverterToJson<dynamic, bool>(
          instance.isPassed, const BoolConverter().toJson),
      'startedAt': const NullableStringConverter().toJson(instance.startedAt),
      'submittedAt':
          const NullableStringConverter().toJson(instance.submittedAt),
      'time_taken_seconds': _$JsonConverterToJson<dynamic, int>(
          instance.timeTakenSeconds, const IntConverter().toJson),
      'duration_minutes': _$JsonConverterToJson<dynamic, int>(
          instance.durationMinutes, const IntConverter().toJson),
      'time_remaining_seconds': _$JsonConverterToJson<dynamic, int>(
          instance.timeRemainingSeconds, const IntConverter().toJson),
      'answers': instance.answers,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
