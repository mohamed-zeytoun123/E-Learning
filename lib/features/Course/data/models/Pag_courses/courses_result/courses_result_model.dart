import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';

class CoursesResultModel {
  final List<CourseModel>? courses;
  final bool hasNextPage;

  CoursesResultModel({this.courses, this.hasNextPage = true});

  factory CoursesResultModel.empty() {
    return CoursesResultModel(courses: [], hasNextPage: false);
  }

  CoursesResultModel copyWith({List<CourseModel>? courses, bool? hasNextPage}) {
    return CoursesResultModel(
      courses: courses ?? this.courses,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }
}
