import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/Course/data/models/university_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'college_detail_model.g.dart';

@JsonSerializable()
class CollegeDetailModel {
  @IntConverter()
  final int id;
  
  @StringConverter()
  final String name;
  
  final UniversityDetailModel university;
  
  CollegeDetailModel({
    required this.id,
    required this.name,
    required this.university,
  });

  //* CopyWith
  CollegeDetailModel copyWith({
    int? id,
    String? name,
    UniversityDetailModel? university,
  }) =>
      CollegeDetailModel(
        id: id ?? this.id,
        name: name ?? this.name,
        university: university ?? this.university,
      );

  factory CollegeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CollegeDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollegeDetailModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory CollegeDetailModel.fromMap(Map<String, dynamic> map) =>
      CollegeDetailModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
