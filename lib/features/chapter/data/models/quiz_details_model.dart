import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_details_model.g.dart';

@JsonSerializable()
class QuizDetailsModel {
  @IntConverter()
  final int id;
  
  @StringConverter()
  final String title;
  
  @StringConverter()
  final String description;
  
  @JsonKey(name: 'chapter_title')
  @StringConverter()
  final String chapterTitle;
  
  @JsonKey(name: 'course_title')
  @StringConverter()
  final String courseTitle;
  
  @JsonKey(name: 'total_points')
  @IntConverter()
  final int totalPoints;
  
  @JsonKey(name: 'passing_score')
  @StringConverter()
  final String passingScore;
  
  @JsonKey(name: 'duration_minutes')
  @IntConverter()
  final int durationMinutes;
  
  @JsonKey(name: 'questions_count')
  @IntConverter()
  final int questionsCount;
  
  @JsonKey(name: 'max_attempts')
  @IntConverter()
  final int maxAttempts;
  
  @JsonKey(name: 'has_attempted')
  @BoolConverter()
  final bool hasAttempted;
  
  @JsonKey(name: 'created_at')
  @StringConverter()
  final String createdAt;
  
  @JsonKey(name: 'attempt_id')
  @IntConverter()
  final int? attemptId;
  
  @JsonKey(name: 'attempt_status')
  @NullableStringConverter()
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

  factory QuizDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$QuizDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizDetailsModelToJson(this);
}

