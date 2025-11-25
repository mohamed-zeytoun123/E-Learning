import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'choice_model.g.dart';

@JsonSerializable()
class ChoiceModel {
  @IntConverter()
  final int id;
  
  @JsonKey(name: 'choice_text')
  @StringConverter()
  final String choiceText;
  
  @IntConverter()
  final int order;

  ChoiceModel({
    required this.id,
    required this.choiceText,
    required this.order,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);
}

