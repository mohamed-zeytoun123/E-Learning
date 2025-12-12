// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDataInfoModel {
  final int id;
  final String phone;
  final String username;
  final String fullName;
  final int universityId;
  final String universityName;
  final int collegeId;
  final String collegeName;
  final int studyYearId;
  final String studyYearName;
  final String email;

  UserDataInfoModel({
    required this.id,
    required this.phone,
    required this.username,
    required this.fullName,
    required this.universityId,
    required this.universityName,
    required this.collegeId,
    required this.collegeName,
    required this.studyYearId,
    required this.studyYearName,
    required this.email,
  });

  UserDataInfoModel copyWith({
    int? id,
    String? phone,
    String? username,
    String? fullName,
    int? universityId,
    String? universityName,
    int? collegeId,
    String? collegeName,
    int? studyYearId,
    String? studyYearName,
    String? email,
  }) =>
      UserDataInfoModel(
        id: id ?? this.id,
        phone: phone ?? this.phone,
        username: username ?? this.username,
        fullName: fullName ?? this.fullName,
        universityId: universityId ?? this.universityId,
        universityName: universityName ?? this.universityName,
        collegeId: collegeId ?? this.collegeId,
        collegeName: collegeName ?? this.collegeName,
        studyYearId: studyYearId ?? this.studyYearId,
        studyYearName: studyYearName ?? this.studyYearName,
        email: email ?? this.email,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phone': phone,
      'username': username,
      'fullName': fullName,
      'universityId': universityId,
      'universityName': universityName,
      'collegeId': collegeId,
      'collegeName': collegeName,
      'studyYearId': studyYearId,
      'studyYearName': studyYearName,
      'email': email,
    };
  }

  factory UserDataInfoModel.fromMap(Map<String, dynamic> map) {
    return UserDataInfoModel(
      id: map['id'] as int? ?? 0,
      phone: map['phone'] as String? ?? '',
      username: map['username'] as String? ?? '',
      fullName: map['full_name'] as String? ?? '',
      universityId: map['university_id'] as int? ?? 0,
      universityName: map['university_name'] as String? ?? '',
      collegeId: map['college_id'] as int? ?? 0,
      collegeName: map['college_name'] as String? ?? '',
      studyYearId: map['study_year_id'] as int? ?? 0,
      studyYearName: map['study_year_name'] as String? ?? '',
      email: map['email'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataInfoModel.fromJson(String source) =>
      UserDataInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
