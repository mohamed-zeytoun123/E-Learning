import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/chapter/data/models/attempt_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'submit_completed_model.g.dart';

@JsonSerializable()
class SubmitCompletedModel {
  @NullableStringConverter()
  final String? message;
  
  @JsonKey()
  final AttemptModel? attempt;

  SubmitCompletedModel({this.message, this.attempt});

  factory SubmitCompletedModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitCompletedModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitCompletedModelToJson(this);
  
  static AttemptModel? _nullableAttemptFromJson(dynamic json) => json == null ? null : AttemptModel.fromJson(json);
  static Object? _nullableAttemptToJson(AttemptModel? object) => object?.toJson();
}

