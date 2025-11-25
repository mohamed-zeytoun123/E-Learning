import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_course_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teacher_model.g.dart';

@JsonSerializable()
class TeacherModel {
  @IntConverter()
  final int id;
  
  @JsonKey(name: 'full_name')
  @StringConverter()
  final String fullName;
  
  @NullableStringConverter()
  final String? bio;
  
  @NullableStringConverter()
  final String? avatar;
  
  @NullableStringConverter()
  final String? qualifications;
  
  @JsonKey(name: 'courses_number')
  @IntConverter()
  final int coursesNumber;
  
  @IntConverter()
  final int students;
  
  final List<TeacherCourseModel> courses;
  
  TeacherModel({
    required this.id,
    required this.fullName,
    this.bio,
    this.avatar,
    this.qualifications,
    required this.coursesNumber,
    required this.students,
    required this.courses,
  });

  TeacherModel copyWith({
    int? id,
    String? fullName,
    String? bio,
    String? avatar,
    String? qualifications,
    int? coursesNumber,
    int? students,
    List<TeacherCourseModel>? courses,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      bio: bio ?? this.bio,
      avatar: avatar ?? this.avatar,
      qualifications: qualifications ?? this.qualifications,
      coursesNumber: coursesNumber ?? this.coursesNumber,
      students: students ?? this.students,
      courses: courses ?? this.courses,
    );
  }

  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory TeacherModel.fromMap(Map<String, dynamic> map) =>
      TeacherModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
