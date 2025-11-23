import 'package:e_learning/features/chapter/data/models/quize/submit/answer_submit_model.dart';

class AttemptModel {
  final int? id;
  final int? quiz;
  final String? quizTitle;
  final String? quizDescription;
  final String? status;
  final String? score;
  final int? totalPoints;
  final String? percentage;
  final String? passingScore;
  final bool? isPassed;
  final String? startedAt;
  final String? submittedAt;
  final int? timeTakenSeconds;
  final int? durationMinutes;
  final int? timeRemainingSeconds;
  final List<AnswerSubmitModel>? answers;

  AttemptModel({
    this.id,
    this.quiz,
    this.quizTitle,
    this.quizDescription,
    this.status,
    this.score,
    this.totalPoints,
    this.percentage,
    this.passingScore,
    this.isPassed,
    this.startedAt,
    this.submittedAt,
    this.timeTakenSeconds,
    this.durationMinutes,
    this.timeRemainingSeconds,
    this.answers,
  });

  factory AttemptModel.fromJson(Map<String, dynamic> json) {
    return AttemptModel(
      id: json['id'],
      quiz: json['quiz'],
      quizTitle: json['quiz_title']?.toString(),
      quizDescription: json['quiz_description']?.toString(),
      status: json['status']?.toString(),
      score: json['score']?.toString(),
      totalPoints: json['total_points'],
      percentage: json['percentage']?.toString(),
      passingScore: json['passing_score']?.toString(),
      isPassed: json['is_passed'] as bool?,
      startedAt: json['started_at']?.toString(),
      submittedAt: json['submitted_at']?.toString(),
      timeTakenSeconds: json['time_taken_seconds'],
      durationMinutes: json['duration_minutes'],
      timeRemainingSeconds: json['time_remaining_seconds'],
      answers: json['answers'] != null
          ? (json['answers'] as List)
                .map((e) => AnswerSubmitModel.fromJson(e))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz': quiz,
      'quiz_title': quizTitle,
      'quiz_description': quizDescription,
      'status': status,
      'score': score,
      'total_points': totalPoints,
      'percentage': percentage,
      'passing_score': passingScore,
      'is_passed': isPassed,
      'started_at': startedAt,
      'submitted_at': submittedAt,
      'time_taken_seconds': timeTakenSeconds,
      'duration_minutes': durationMinutes,
      'time_remaining_seconds': timeRemainingSeconds,
      'answers': answers?.map((e) => e.toJson()).toList(),
    };
  }
}
