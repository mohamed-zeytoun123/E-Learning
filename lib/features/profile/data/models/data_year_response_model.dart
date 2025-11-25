import 'package:e_learning/core/model/paginated_model.dart';
import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_year_response_model.g.dart';

@JsonSerializable()
class YearDataModel {
  @IntConverter()
  final int id;

  @JsonKey(name: 'year_number')
  @IntConverter()
  final int yearNumber;

  @StringConverter()
  final String name;

  @StringConverter()
  final String description;

  @JsonKey(name: 'is_active')
  @BoolConverter()
  final bool isActive;

  YearDataModel({
    required this.id,
    required this.yearNumber,
    required this.name,
    required this.description,
    required this.isActive,
  });

  YearDataModel copyWith({
    int? id,
    int? yearNumber,
    String? name,
    String? description,
    bool? isActive,
  }) =>
      YearDataModel(
        id: id ?? this.id,
        yearNumber: yearNumber ?? this.yearNumber,
        name: name ?? this.name,
        description: description ?? this.description,
        isActive: isActive ?? this.isActive,
      );

  factory YearDataModel.fromJson(Map<String, dynamic> json) =>
      _$YearDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$YearDataModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory YearDataModel.fromMap(Map<String, dynamic> map) =>
      YearDataModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}

typedef DataResonseYearStudent = PaginationModel<YearDataModel>;
