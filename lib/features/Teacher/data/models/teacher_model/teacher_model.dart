import 'package:e_learning/features/Teacher/data/models/teacher_course_model.dart';

class TeacherModel {
  final int id;
  final String fullName;
  final String? bio;
  final String? avatar;
  final String? qualifications;
  final int coursesNumber;
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

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    final List<TeacherCourseModel> coursesList = [];
    if (map['courses'] != null && map['courses'] is List) {
      for (var course in map['courses']) {
        if (course is Map<String, dynamic>) {
          coursesList.add(TeacherCourseModel.fromMap(course));
        }
      }
    }

    return TeacherModel(
      id: map['id'] ?? 0,
      fullName: map['full_name'] ?? '',
      bio: map['bio'] as String?,
      avatar: map['avatar'] as String?,
      qualifications: map['qualifications'] as String?,
      coursesNumber: map['courses_number'] ?? 0,
      students: map['students'] ?? 0,
      courses: coursesList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'bio': bio,
      'avatar': avatar,
      'qualifications': qualifications,
      'courses_number': coursesNumber,
      'students': students,
      'courses': courses.map((course) => course.toMap()).toList(),
    };
  }
}
