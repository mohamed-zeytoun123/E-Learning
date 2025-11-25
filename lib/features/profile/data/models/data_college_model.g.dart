// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_college_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

College _$CollegeFromJson(Map json) => College(
      id: const IntConverter().fromJson(json['id']),
      name: const StringConverter().fromJson(json['name']),
      slug: const StringConverter().fromJson(json['slug']),
      university: const IntConverter().fromJson(json['university']),
      universityName: const StringConverter().fromJson(json['university_name']),
    );

Map<String, dynamic> _$CollegeToJson(College instance) => <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'name': const StringConverter().toJson(instance.name),
      'slug': const StringConverter().toJson(instance.slug),
      'university': const IntConverter().toJson(instance.university),
      'university_name':
          const StringConverter().toJson(instance.universityName),
    };
