// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_completed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitCompletedModel _$SubmitCompletedModelFromJson(Map json) =>
    SubmitCompletedModel(
      message: const NullableStringConverter().fromJson(json['message']),
      attempt: json['attempt'] == null
          ? null
          : AttemptModel.fromJson(
              Map<String, dynamic>.from(json['attempt'] as Map)),
    );

Map<String, dynamic> _$SubmitCompletedModelToJson(
        SubmitCompletedModel instance) =>
    <String, dynamic>{
      'message': const NullableStringConverter().toJson(instance.message),
      'attempt': instance.attempt,
    };
