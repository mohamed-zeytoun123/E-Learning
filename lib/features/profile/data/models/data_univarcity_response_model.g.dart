// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_univarcity_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniData _$UniDataFromJson(Map json) => UniData(
      id: const IntConverter().fromJson(json['id']),
      name: const StringConverter().fromJson(json['name']),
      slug: const StringConverter().fromJson(json['slug']),
    );

Map<String, dynamic> _$UniDataToJson(UniData instance) => <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'name': const StringConverter().toJson(instance.name),
      'slug': const StringConverter().toJson(instance.slug),
    };
