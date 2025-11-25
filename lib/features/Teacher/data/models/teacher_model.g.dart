// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherModel _$TeacherModelFromJson(Map json) => TeacherModel(
      id: const IntConverter().fromJson(json['id']),
      fullName: const StringConverter().fromJson(json['full_name']),
      bio: const NullableStringConverter().fromJson(json['bio']),
      avatar: const NullableStringConverter().fromJson(json['avatar']),
      qualifications:
          const NullableStringConverter().fromJson(json['qualifications']),
      coursesNumber: const IntConverter().fromJson(json['courses_number']),
      students: const IntConverter().fromJson(json['students']),
      courses: (json['courses'] as List<dynamic>)
          .map((e) =>
              TeacherCourseModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'full_name': const StringConverter().toJson(instance.fullName),
      'bio': const NullableStringConverter().toJson(instance.bio),
      'avatar': const NullableStringConverter().toJson(instance.avatar),
      'qualifications':
          const NullableStringConverter().toJson(instance.qualifications),
      'courses_number': const IntConverter().toJson(instance.coursesNumber),
      'students': const IntConverter().toJson(instance.students),
      'courses': instance.courses,
    };
