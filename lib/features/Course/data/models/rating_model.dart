import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel {
  @IntConverter()
  final int id;
  
  @JsonKey(name: 'student_name')
  @StringConverter()
  final String studentName;
  
  @JsonKey(name: 'student_image')
  @NullableStringConverter()
  final String? studentImage;
  
  @IntConverter()
  final int rating;
  
  @StringConverter()
  final String comment;
  
  @JsonKey(name: 'is_featured')
  @BoolConverter()
  final bool isFeatured;
  
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  final DateTime createdAt;

  RatingModel({
    required this.id,
    required this.studentName,
    this.studentImage,
    required this.rating,
    required this.comment,
    required this.isFeatured,
    required this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}

