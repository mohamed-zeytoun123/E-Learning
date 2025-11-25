// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map json) => QuestionModel(
      id: const IntConverter().fromJson(json['id']),
      questionType: const StringConverter().fromJson(json['question_type']),
      questionText: const StringConverter().fromJson(json['question_text']),
      points: const IntConverter().fromJson(json['points']),
      order: const IntConverter().fromJson(json['order']),
      image: const NullableStringConverter().fromJson(json['image']),
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'question_type': const StringConverter().toJson(instance.questionType),
      'question_text': const StringConverter().toJson(instance.questionText),
      'points': const IntConverter().toJson(instance.points),
      'order': const IntConverter().toJson(instance.order),
      'image': const NullableStringConverter().toJson(instance.image),
      'choices': instance.choices,
    };
