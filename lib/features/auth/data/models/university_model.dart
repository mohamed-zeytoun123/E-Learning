import 'package:e_learning/core/utils/json_converters.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'university_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class UniversityModel extends HiveObject {
  @HiveField(0)
  @IntConverter()
  final int id;

  @HiveField(1)
  @StringConverter()
  final String name;

  @HiveField(2)
  @StringConverter()
  final String slug;
  
  UniversityModel({required this.id, required this.name, required this.slug});

  UniversityModel copyWith({int? id, String? name, String? slug}) =>
      UniversityModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  factory UniversityModel.fromJson(Map<String, dynamic> json) =>
      _$UniversityModelFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory UniversityModel.fromMap(Map<String, dynamic> map) =>
      UniversityModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
