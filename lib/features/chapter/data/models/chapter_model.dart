class ChapterModel {
  final int id;
  final int course;
  final String title;
  final String description;
  final int attachmentsCount;
  final DateTime createdAt;

  ChapterModel({
    required this.id,
    required this.course,
    required this.title,
    required this.description,
    required this.attachmentsCount,
    required this.createdAt,
  });

  ChapterModel copyWith({
    int? id,
    int? course,
    String? title,
    String? description,
    int? attachmentsCount,
    DateTime? createdAt,
  }) => ChapterModel(
    id: id ?? this.id,
    course: course ?? this.course,
    title: title ?? this.title,
    description: description ?? this.description,
    attachmentsCount: attachmentsCount ?? this.attachmentsCount,
    createdAt: createdAt ?? this.createdAt,
  );

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as int,
      course: json['course'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      attachmentsCount: json['attachments_count'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course': course,
      'title': title,
      'description': description,
      'attachments_count': attachmentsCount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
