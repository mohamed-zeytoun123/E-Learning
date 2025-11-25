// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_submit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerSubmitModel _$AnswerSubmitModelFromJson(Map json) => AnswerSubmitModel(
      id: const IntConverter().fromJson(json['id']),
      question: const IntConverter().fromJson(json['question']),
      questionText:
          const NullableStringConverter().fromJson(json['questionText']),
      questionType:
          const NullableStringConverter().fromJson(json['questionType']),
      questionPoints: const IntConverter().fromJson(json['question_points']),
      selectedChoice: const IntConverter().fromJson(json['selected_choice']),
      selectedChoiceText:
          const NullableStringConverter().fromJson(json['selectedChoiceText']),
      isCorrect: const BoolConverter().fromJson(json['is_correct']),
      pointsEarned:
          const NullableStringConverter().fromJson(json['pointsEarned']),
      correctChoice: json['correct_choice'] == null
          ? null
          : ChoiceModel.fromJson(
              Map<String, dynamic>.from(json['correct_choice'] as Map)),
      answeredAt: const NullableStringConverter().fromJson(json['answeredAt']),
    );

Map<String, dynamic> _$AnswerSubmitModelToJson(AnswerSubmitModel instance) =>
    <String, dynamic>{
      'id': _$JsonConverterToJson<dynamic, int>(
          instance.id, const IntConverter().toJson),
      'question': _$JsonConverterToJson<dynamic, int>(
          instance.question, const IntConverter().toJson),
      'questionText':
          const NullableStringConverter().toJson(instance.questionText),
      'questionType':
          const NullableStringConverter().toJson(instance.questionType),
      'question_points': _$JsonConverterToJson<dynamic, int>(
          instance.questionPoints, const IntConverter().toJson),
      'selected_choice': _$JsonConverterToJson<dynamic, int>(
          instance.selectedChoice, const IntConverter().toJson),
      'selectedChoiceText':
          const NullableStringConverter().toJson(instance.selectedChoiceText),
      'is_correct': _$JsonConverterToJson<dynamic, bool>(
          instance.isCorrect, const BoolConverter().toJson),
      'pointsEarned':
          const NullableStringConverter().toJson(instance.pointsEarned),
      'correct_choice': instance.correctChoice,
      'answeredAt': const NullableStringConverter().toJson(instance.answeredAt),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
