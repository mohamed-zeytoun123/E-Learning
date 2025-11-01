class CourseRatingModel {
  final int id;
  final int student;
  final String studentName;
  final int course;
  final String courseTitle;
  final int rating;
  final String comment;
  final bool isFeatured;
  final bool isHidden;
  final String createdAt;
  final String updatedAt;

  const CourseRatingModel({
    required this.id,
    required this.student,
    required this.studentName,
    required this.course,
    required this.courseTitle,
    required this.rating,
    required this.comment,
    required this.isFeatured,
    required this.isHidden,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseRatingModel.fromJson(Map<String, dynamic> json) {
    return CourseRatingModel(
      id: json['id'] as int,
      student: json['student'] as int,
      studentName: json['student_name'] as String,
      course: json['course'] as int,
      courseTitle: json['course_title'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      isFeatured: json['is_featured'] as bool,
      isHidden: json['is_hidden'] as bool,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student': student,
      'student_name': studentName,
      'course': course,
      'course_title': courseTitle,
      'rating': rating,
      'comment': comment,
      'is_featured': isFeatured,
      'is_hidden': isHidden,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  CourseRatingModel copyWith({
    int? id,
    int? student,
    String? studentName,
    int? course,
    String? courseTitle,
    int? rating,
    String? comment,
    bool? isFeatured,
    bool? isHidden,
    String? createdAt,
    String? updatedAt,
  }) {
    return CourseRatingModel(
      id: id ?? this.id,
      student: student ?? this.student,
      studentName: studentName ?? this.studentName,
      course: course ?? this.course,
      courseTitle: courseTitle ?? this.courseTitle,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      isFeatured: isFeatured ?? this.isFeatured,
      isHidden: isHidden ?? this.isHidden,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
