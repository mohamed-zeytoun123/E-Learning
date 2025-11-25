// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_year_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearDataModel _$YearDataModelFromJson(Map json) => YearDataModel(
      id: const IntConverter().fromJson(json['id']),
      yearNumber: const IntConverter().fromJson(json['year_number']),
      name: const StringConverter().fromJson(json['name']),
      description: const StringConverter().fromJson(json['description']),
      isActive: const BoolConverter().fromJson(json['is_active']),
    );

Map<String, dynamic> _$YearDataModelToJson(YearDataModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'year_number': const IntConverter().toJson(instance.yearNumber),
      'name': const StringConverter().toJson(instance.name),
      'description': const StringConverter().toJson(instance.description),
      'is_active': const BoolConverter().toJson(instance.isActive),
    };
