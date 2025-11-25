// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerModel _$AnswerModelFromJson(Map json) => AnswerModel(
      message: const NullableStringConverter().fromJson(json['message']),
      answerId: const IntConverter().fromJson(json['answer_id']),
      questionId: const IntConverter().fromJson(json['question_id']),
      created: const BoolConverter().fromJson(json['created']),
    );

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      'message': const NullableStringConverter().toJson(instance.message),
      'answer_id': _$JsonConverterToJson<dynamic, int>(
          instance.answerId, const IntConverter().toJson),
      'question_id': _$JsonConverterToJson<dynamic, int>(
          instance.questionId, const IntConverter().toJson),
      'created': _$JsonConverterToJson<dynamic, bool>(
          instance.created, const BoolConverter().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
