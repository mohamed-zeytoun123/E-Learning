import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/chapter/data/models/choice_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_submit_model.g.dart';

@JsonSerializable()
class AnswerSubmitModel {
  @IntConverter()
  final int? id;
  
  @IntConverter()
  final int? question;
  
  @NullableStringConverter()
  final String? questionText;
  
  @NullableStringConverter()
  final String? questionType;
  
  @JsonKey(name: 'question_points')
  @IntConverter()
  final int? questionPoints;
  
  @JsonKey(name: 'selected_choice')
  @IntConverter()
  final int? selectedChoice;
  
  @NullableStringConverter()
  final String? selectedChoiceText;
  
  @JsonKey(name: 'is_correct')
  @BoolConverter()
  final bool? isCorrect;
  
  @NullableStringConverter()
  final String? pointsEarned;
  
  @JsonKey(name: 'correct_choice')
  final ChoiceModel? correctChoice;
  
  @NullableStringConverter()
  final String? answeredAt;

  AnswerSubmitModel({
    this.id,
    this.question,
    this.questionText,
    this.questionType,
    this.questionPoints,
    this.selectedChoice,
    this.selectedChoiceText,
    this.isCorrect,
    this.pointsEarned,
    this.correctChoice,
    this.answeredAt,
  });

  factory AnswerSubmitModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerSubmitModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerSubmitModelToJson(this);
  
  static ChoiceModel? _nullableChoiceFromJson(dynamic json) => json == null ? null : ChoiceModel.fromJson(json as Map<String, dynamic>);
  static Object? _nullableChoiceToJson(ChoiceModel? object) => object?.toJson();
}

