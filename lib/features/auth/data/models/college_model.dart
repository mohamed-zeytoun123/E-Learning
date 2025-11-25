import 'dart:convert';

import 'package:e_learning/core/utils/json_converters.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'college_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class CollegeModel extends HiveObject {
  @HiveField(0)
  @IntConverter()
  final int id;

  @HiveField(1)
  @StringConverter()
  final String name;

  @HiveField(2)
  @StringConverter()
  final String slug;

  @HiveField(3)
  @IntConverter()
  final int university;

  @HiveField(4)
  @JsonKey(name: 'university_name')
  @StringConverter()
  final String universityName;
  
  CollegeModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.university,
    required this.universityName,
  });

  CollegeModel copyWith({
    int? id,
    String? name,
    String? slug,
    int? university,
    String? universityName,
  }) =>
      CollegeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        university: university ?? this.university,
        universityName: universityName ?? this.universityName,
      );

  factory CollegeModel.fromJson(Map<String, dynamic> json) =>
      _$CollegeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollegeModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory CollegeModel.fromMap(Map<String, dynamic> map) =>
      CollegeModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  // Keep string-based JSON methods for backward compatibility
  factory CollegeModel.fromJsonString(String source) =>
      CollegeModel.fromJson(json.decode(source));

  String toJsonString() => json.encode(toJson());
}
