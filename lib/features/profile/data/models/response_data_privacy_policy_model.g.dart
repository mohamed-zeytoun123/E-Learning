// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data_privacy_policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseInfoAppModel _$ResponseInfoAppModelFromJson(Map json) =>
    ResponseInfoAppModel(
      id: const IntConverter().fromJson(json['id']),
      title: const StringConverter().fromJson(json['title']),
      content: const StringConverter().fromJson(json['content']),
    );

Map<String, dynamic> _$ResponseInfoAppModelToJson(
        ResponseInfoAppModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'title': const StringConverter().toJson(instance.title),
      'content': const StringConverter().toJson(instance.content),
    };
