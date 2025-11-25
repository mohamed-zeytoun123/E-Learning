import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'university_detail_model.g.dart';

@JsonSerializable()
class UniversityDetailModel {
  @IntConverter()
  final int id;
  
  @StringConverter()
  final String name;
  
  UniversityDetailModel({required this.id, required this.name});

  //* CopyWith
  UniversityDetailModel copyWith({int? id, String? name}) =>
      UniversityDetailModel(id: id ?? this.id, name: name ?? this.name);

  factory UniversityDetailModel.fromJson(Map<String, dynamic> json) =>
      _$UniversityDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityDetailModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory UniversityDetailModel.fromMap(Map<String, dynamic> map) =>
      UniversityDetailModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
