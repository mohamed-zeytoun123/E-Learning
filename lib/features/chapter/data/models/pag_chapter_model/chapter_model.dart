class ChapterModel {
  final int id;
  final int course;
  final String title;
  final String description;
  final int attachmentsCount;
  final int videosCount;
  final DateTime createdAt;

  ChapterModel({
    required this.id,
    required this.course,
    required this.title,
    required this.description,
    required this.attachmentsCount,
    required this.videosCount,
    required this.createdAt,
  });

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      id: map['id'] ?? 0,
      course: map['course'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      attachmentsCount: map['attachments_count'] ?? 0,
      videosCount: map['videos_count'] ?? 0,
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
      'created_at': createdAt.toIso8601String(),
    };
  }
}
