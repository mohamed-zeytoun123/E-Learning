// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataInfoModel _$UserDataInfoModelFromJson(Map json) => UserDataInfoModel(
      id: const IntConverter().fromJson(json['id']),
      phone: const StringConverter().fromJson(json['phone']),
      username: const StringConverter().fromJson(json['username']),
      fullName: const StringConverter().fromJson(json['full_name']),
      universityId: const IntConverter().fromJson(json['university_id']),
      universityName: const StringConverter().fromJson(json['university_name']),
      collegeId: const IntConverter().fromJson(json['college_id']),
      collegeName: const StringConverter().fromJson(json['college_name']),
      studyYearId: const IntConverter().fromJson(json['study_year_id']),
      studyYearName: const StringConverter().fromJson(json['study_year_name']),
      email: const StringConverter().fromJson(json['email']),
    );

Map<String, dynamic> _$UserDataInfoModelToJson(UserDataInfoModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'phone': const StringConverter().toJson(instance.phone),
      'username': const StringConverter().toJson(instance.username),
      'full_name': const StringConverter().toJson(instance.fullName),
      'university_id': const IntConverter().toJson(instance.universityId),
      'university_name':
          const StringConverter().toJson(instance.universityName),
      'college_id': const IntConverter().toJson(instance.collegeId),
      'college_name': const StringConverter().toJson(instance.collegeName),
      'study_year_id': const IntConverter().toJson(instance.studyYearId),
      'study_year_name': const StringConverter().toJson(instance.studyYearName),
      'email': const StringConverter().toJson(instance.email),
    };
