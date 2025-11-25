// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityDetailModel _$UniversityDetailModelFromJson(Map json) =>
    UniversityDetailModel(
      id: const IntConverter().fromJson(json['id']),
      name: const StringConverter().fromJson(json['name']),
    );

Map<String, dynamic> _$UniversityDetailModelToJson(
        UniversityDetailModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'name': const StringConverter().toJson(instance.name),
    };
