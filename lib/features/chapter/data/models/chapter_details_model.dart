class ChapterDetailsModel {
  final int id;
  final int course;
  final String courseTitle;
  final String title;
  final String description;
  final int quizCount;
  final int totalVideosCount;
  final double totalVideoDurationMinutes;
  final DateTime createdAt;

  ChapterDetailsModel({
    required this.id,
    required this.course,
    required this.courseTitle,
    required this.title,
    required this.description,
    required this.quizCount,
    required this.totalVideosCount,
    required this.totalVideoDurationMinutes,
    required this.createdAt,
  });

  factory ChapterDetailsModel.fromMap(Map<String, dynamic> map) {
    return ChapterDetailsModel(
      id: map['id'] ?? 0,
      course: map['course'] ?? 0,
      courseTitle: map['course_title'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      quizCount: map['quiz_count'] ?? 0,
      totalVideosCount: map['total_videos_count'] ?? 0,
      totalVideoDurationMinutes: (map['total_video_duration_minutes'] ?? 0)
          .toDouble(),
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
    int? quizCount,
    int? totalVideosCount,
    double? totalVideoDurationMinutes,
    DateTime? createdAt,
  }) {
    return ChapterDetailsModel(
      id: id ?? this.id,
      course: course ?? this.course,
      courseTitle: courseTitle ?? this.courseTitle,
      title: title ?? this.title,
      description: description ?? this.description,
      quizCount: quizCount ?? this.quizCount,
      totalVideosCount: totalVideosCount ?? this.totalVideosCount,
      totalVideoDurationMinutes:
          totalVideoDurationMinutes ?? this.totalVideoDurationMinutes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
