import 'package:e_learning/features/chapter/data/models/quize/question_model.dart';

class StartQuizModel {
  final int id;
  final int quiz;
  final String quizTitle;
  final int totalPoints;
  final int durationMinutes;
  final String status;
  final DateTime startedAt;
  final List<QuestionModel> questions;

  StartQuizModel({
    required this.id,
    required this.quiz,
    required this.quizTitle,
    required this.totalPoints,
    required this.durationMinutes,
    required this.status,
    required this.startedAt,
    required this.questions,
  });

  factory StartQuizModel.fromJson(Map<String, dynamic> json) {
    return StartQuizModel(
      id: json['id'] ?? 0,
      quiz: json['quiz'] ?? 0,
      quizTitle: json['quiz_title'] ?? "",
      totalPoints: json['total_points'] ?? 0,
      durationMinutes: json['duration_minutes'] ?? 0,
      status: json['status'] ?? "",
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'])
          : DateTime.now(),
      questions: json['questions'] != null
          ? List<QuestionModel>.from(
              json['questions'].map((e) => QuestionModel.fromJson(e)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "quiz": quiz,
    "quiz_title": quizTitle,
    "total_points": totalPoints,
    "duration_minutes": durationMinutes,
    "status": status,
    "started_at": startedAt.toIso8601String(),
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}
