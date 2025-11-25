// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoiceModel _$ChoiceModelFromJson(Map json) => ChoiceModel(
      id: const IntConverter().fromJson(json['id']),
      choiceText: const StringConverter().fromJson(json['choice_text']),
      order: const IntConverter().fromJson(json['order']),
    );

Map<String, dynamic> _$ChoiceModelToJson(ChoiceModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'choice_text': const StringConverter().toJson(instance.choiceText),
      'order': const IntConverter().toJson(instance.order),
    };
