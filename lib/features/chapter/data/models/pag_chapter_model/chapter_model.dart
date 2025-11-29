class ChapterModel {
  final int id;
  final int course;
  final String title;
  final String description;
  final int attachmentsCount;
  final int videosCount;
  final double totalVideoDurationMinutes;
  final DateTime createdAt;

  ChapterModel({
    required this.id,
    required this.course,
    required this.title,
    required this.description,
    required this.attachmentsCount,
    required this.videosCount,
    required this.totalVideoDurationMinutes,
    required this.createdAt,
  });

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      return double.tryParse(value.toString()) ?? 0.0;
    }

    return ChapterModel(
      id: map['id'] ?? 0,
      course: map['course'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      attachmentsCount: map['attachments_count'] ?? 0,
      videosCount: map['videos_count'] ?? 0,
      totalVideoDurationMinutes: parseDouble(
        map['total_video_duration_minutes'],
      ),
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course': course,
      'title': title,
      'description': description,
      'attachments_count': attachmentsCount,
      'videos_count': videosCount,
      'total_video_duration_minutes': totalVideoDurationMinutes,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
