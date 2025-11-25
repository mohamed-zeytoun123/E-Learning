import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/chapter/data/models/question_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'start_quiz_model.g.dart';

@JsonSerializable()
class StartQuizModel {
  @IntConverter()
  final int id;
  
  @IntConverter()
  final int quiz;
  
  @JsonKey(name: 'quiz_title')
  @StringConverter()
  final String quizTitle;
  
  @JsonKey(name: 'total_points')
  @IntConverter()
  final int totalPoints;
  
  @JsonKey(name: 'duration_minutes')
  @IntConverter()
  final int durationMinutes;
  
  @StringConverter()
  final String status;
  
  @JsonKey(name: 'started_at')
  @DateTimeConverter()
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

  factory StartQuizModel.fromJson(Map<String, dynamic> json) =>
      _$StartQuizModelFromJson(json);

  Map<String, dynamic> toJson() => _$StartQuizModelToJson(this);
}

