import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_info_model.g.dart';

@JsonSerializable()
class UserDataInfoModel {
  @IntConverter()
  final int id;
  
  @StringConverter()
  final String phone;
  
  @StringConverter()
  final String username;
  
  @JsonKey(name: 'full_name')
  @StringConverter()
  final String fullName;
  
  @JsonKey(name: 'university_id')
  @IntConverter()
  final int universityId;
  
  @JsonKey(name: 'university_name')
  @StringConverter()
  final String universityName;
  
  @JsonKey(name: 'college_id')
  @IntConverter()
  final int collegeId;
  
  @JsonKey(name: 'college_name')
  @StringConverter()
  final String collegeName;
  
  @JsonKey(name: 'study_year_id')
  @IntConverter()
  final int studyYearId;
  
  @JsonKey(name: 'study_year_name')
  @StringConverter()
  final String studyYearName;
  
  @StringConverter()
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

  factory UserDataInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataInfoModelToJson(this);
  
  // Keep fromMap and toMap for backward compatibility
  factory UserDataInfoModel.fromMap(Map<String, dynamic> map) =>
      UserDataInfoModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
