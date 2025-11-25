import 'package:e_learning/core/model/paginated_model.dart';
import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_college_model.g.dart';

@JsonSerializable()
class College {
  @IntConverter()
  final int id;

  @StringConverter()
  final String name;

  @StringConverter()
  final String slug;

  @IntConverter()
  final int university;

  @JsonKey(name: 'university_name')
  @StringConverter()
  final String universityName;

  College({
    required this.id,
    required this.name,
    required this.slug,
    required this.university,
    required this.universityName,
  });

  College copyWith({
    int? id,
    String? name,
    String? slug,
    int? university,
    String? universityName,
  }) =>
      College(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        university: university ?? this.university,
        universityName: universityName ?? this.universityName,
      );

  factory College.fromJson(Map<String, dynamic> json) =>
      _$CollegeFromJson(json);

  Map<String, dynamic> toJson() => _$CollegeToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory College.fromMap(Map<String, dynamic> map) => College.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}

typedef DataResonseCollege = PaginationModel<College>;
