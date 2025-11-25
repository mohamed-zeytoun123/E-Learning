import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_model.g.dart';

@JsonSerializable()
class AnswerModel {
  @NullableStringConverter()
  final String? message;
  
  @JsonKey(name: 'answer_id')
  @IntConverter()
  final int? answerId;
  
  @JsonKey(name: 'question_id')
  @IntConverter()
  final int? questionId;
  
  @BoolConverter()
  final bool? created;

  AnswerModel({this.message, this.answerId, this.questionId, this.created});

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}

