// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollegeDetailModel _$CollegeDetailModelFromJson(Map json) => CollegeDetailModel(
      id: const IntConverter().fromJson(json['id']),
      name: const StringConverter().fromJson(json['name']),
      university: UniversityDetailModel.fromJson(
          Map<String, dynamic>.from(json['university'] as Map)),
    );

Map<String, dynamic> _$CollegeDetailModelToJson(CollegeDetailModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'name': const StringConverter().toJson(instance.name),
      'university': instance.university,
    };
