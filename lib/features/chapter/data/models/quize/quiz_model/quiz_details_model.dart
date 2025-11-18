class QuizDetailsModel {
  final int id;
  final String title;
  final String description;
  final String chapterTitle;
  final String courseTitle;
  final int totalPoints;
  final String passingScore;
  final int durationMinutes;
  final int questionsCount;
  final int maxAttempts;
  final bool hasAttempted;
  final String createdAt;
  final int? attemptId;
  final String? attemptStatus;

  QuizDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.chapterTitle,
    required this.courseTitle,
    required this.totalPoints,
    required this.passingScore,
    required this.durationMinutes,
    required this.questionsCount,
    required this.maxAttempts,
    required this.hasAttempted,
    required this.createdAt,
    this.attemptId,
    this.attemptStatus,
  });

  factory QuizDetailsModel.fromJson(Map<String, dynamic> json) {
    return QuizDetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      chapterTitle: json['chapter_title'] ?? '',
      courseTitle: json['course_title'] ?? '',
      totalPoints: json['total_points'] ?? 0,
      passingScore: json['passing_score'] ?? "0",
      durationMinutes: json['duration_minutes'] ?? 0,
      questionsCount: json['questions_count'] ?? 0,
      maxAttempts: json['max_attempts'] ?? 0,
      hasAttempted: json['has_attempted'] ?? false,
      createdAt: json['created_at'] ?? '',
      attemptId: json['attempt_id'],
      attemptStatus: json['attempt_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "chapter_title": chapterTitle,
      "course_title": courseTitle,
      "total_points": totalPoints,
      "passing_score": passingScore,
      "duration_minutes": durationMinutes,
      "questions_count": questionsCount,
      "max_attempts": maxAttempts,
      "has_attempted": hasAttempted,
      "created_at": createdAt,
      "attempt_id": attemptId,
      "attempt_status": attemptStatus,
    };
  }
}
