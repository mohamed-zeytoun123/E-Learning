class ChapterDetailsModel {
  final int id;
  final int course;
  final String courseTitle;
  final String title;
  final String description;
  final DateTime createdAt;

  ChapterDetailsModel({
    required this.id,
    required this.course,
    required this.courseTitle,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory ChapterDetailsModel.fromMap(Map<String, dynamic> map) {
    return ChapterDetailsModel(
      id: map['id'] ?? 0,
      course: map['course'] ?? 0,
      courseTitle: map['course_title'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
    );
  }

  ChapterDetailsModel copyWith({
    int? id,
    int? course,
    String? courseTitle,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return ChapterDetailsModel(
      id: id ?? this.id,
      course: course ?? this.course,
      courseTitle: courseTitle ?? this.courseTitle,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
