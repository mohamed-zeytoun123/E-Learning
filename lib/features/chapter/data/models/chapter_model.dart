import 'attachment_model.dart';
import 'quiz_model.dart';

class ChapterModel {
  final int id;
  final int course;
  final String title;
  final String description;
  final List<AttachmentModel> attachments;
  final List<QuizModel> quizzes;
  final DateTime createdAt;

  ChapterModel({
    required this.id,
    required this.course,
    required this.title,
    required this.description,
    required this.attachments,
    required this.quizzes,
    required this.createdAt,
  });

  factory ChapterModel.fromMap(Map<String, dynamic> map) {
    return ChapterModel(
      id: map['id'] ?? 0,
      course: map['course'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      attachments: map['attachments'] != null
          ? List<AttachmentModel>.from(
              (map['attachments'] as List).map(
                (x) => AttachmentModel.fromJson(x),
              ),
            )
          : [],
      quizzes: map['quiz'] != null
          ? List<QuizModel>.from(
              (map['quiz'] as List).map((x) => QuizModel.fromJson(x)),
            )
          : [],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course': course,
      'title': title,
      'description': description,
      'attachments': attachments.map((x) => x.toJson()).toList(),
      'quiz': quizzes.map((x) => x.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  ChapterModel copyWith({
    int? id,
    int? course,
    String? title,
    String? description,
    List<AttachmentModel>? attachments,
    List<QuizModel>? quizzes,
    DateTime? createdAt,
  }) {
    return ChapterModel(
      id: id ?? this.id,
      course: course ?? this.course,
      title: title ?? this.title,
      description: description ?? this.description,
      attachments: attachments ?? this.attachments,
      quizzes: quizzes ?? this.quizzes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
