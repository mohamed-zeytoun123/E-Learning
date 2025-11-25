import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/chapter/data/models/answer_submit_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attempt_model.g.dart';

@JsonSerializable()
class AttemptModel {
  @JsonKey()
  @IntConverter()
  final int? id;
  
  @JsonKey()
  @IntConverter()
  final int? quiz;
  
  @NullableStringConverter()
  final String? quizTitle;
  
  @NullableStringConverter()
  final String? quizDescription;
  
  @NullableStringConverter()
  final String? status;
  
  @NullableStringConverter()
  final String? score;
  
  @JsonKey(name: 'total_points')
  @IntConverter()
  final int? totalPoints;
  
  @NullableStringConverter()
  final String? percentage;
  
  @NullableStringConverter()
  final String? passingScore;
  
  @JsonKey(name: 'is_passed')
  @BoolConverter()
  final bool? isPassed;
  
  @NullableStringConverter()
  final String? startedAt;
  
  @NullableStringConverter()
  final String? submittedAt;
  
  @JsonKey(name: 'time_taken_seconds')
  @IntConverter()
  final int? timeTakenSeconds;
  
  @JsonKey(name: 'duration_minutes')
  @IntConverter()
  final int? durationMinutes;
  
  @JsonKey(name: 'time_remaining_seconds')
  @IntConverter()
  final int? timeRemainingSeconds;
  
  @JsonKey()
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

  factory AttemptModel.fromJson(Map<String, dynamic> json) =>
      _$AttemptModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttemptModelToJson(this);
}

