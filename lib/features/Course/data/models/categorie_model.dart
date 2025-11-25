import 'dart:convert';
import 'package:e_learning/core/utils/json_converters.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categorie_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CategorieModel {
  @HiveField(0)
  @IntConverter()
  final int id;

  @HiveField(1)
  @StringConverter()
  final String name;

  @HiveField(2)
  @StringConverter()
  final String slug;
  
  CategorieModel({required this.id, required this.name, required this.slug});

  CategorieModel copyWith({int? id, String? name, String? slug}) {
    return CategorieModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  factory CategorieModel.fromJson(Map<String, dynamic> json) =>
      _$CategorieModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategorieModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory CategorieModel.fromMap(Map<String, dynamic> map) =>
      CategorieModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  // Keep string-based JSON methods for backward compatibility
  factory CategorieModel.fromJsonString(String source) =>
      CategorieModel.fromJson(json.decode(source));

  String toJsonString() => json.encode(toJson());
}
