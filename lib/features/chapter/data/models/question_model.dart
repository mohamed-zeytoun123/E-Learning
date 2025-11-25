import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/chapter/data/models/choice_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  @IntConverter()
  final int id;
  
  @JsonKey(name: 'question_type')
  @StringConverter()
  final String questionType;
  
  @JsonKey(name: 'question_text')
  @StringConverter()
  final String questionText;
  
  @IntConverter()
  final int points;
  
  @IntConverter()
  final int order;
  
  @NullableStringConverter()
  final String? image;
  
  final List<ChoiceModel> choices;

  QuestionModel({
    required this.id,
    required this.questionType,
    required this.questionText,
    required this.points,
    required this.order,
    required this.image,
    required this.choices,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

