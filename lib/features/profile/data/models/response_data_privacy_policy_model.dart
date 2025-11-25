import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_data_privacy_policy_model.g.dart';

@JsonSerializable()
class ResponseInfoAppModel {
  @IntConverter()
  final int id;

  @StringConverter()
  final String title;

  @StringConverter()
  final String content;

  ResponseInfoAppModel({
    required this.id,
    required this.title,
    required this.content,
  });

  ResponseInfoAppModel copyWith({
    int? id,
    String? title,
    String? content,
  }) =>
      ResponseInfoAppModel(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
      );

  factory ResponseInfoAppModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseInfoAppModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseInfoAppModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory ResponseInfoAppModel.fromMap(Map<String, dynamic> map) =>
      ResponseInfoAppModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
