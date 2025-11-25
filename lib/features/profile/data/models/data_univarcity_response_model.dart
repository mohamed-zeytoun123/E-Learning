import 'package:e_learning/core/model/paginated_model.dart';
import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_univarcity_response_model.g.dart';

@JsonSerializable()
class UniData {
  @IntConverter()
  final int id;
  
  @StringConverter()
  final String name;
  
  @StringConverter()
  final String slug;

  UniData({
    required this.id,
    required this.name,
    required this.slug,
  });

  UniData copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      UniData(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  factory UniData.fromJson(Map<String, dynamic> json) =>
      _$UniDataFromJson(json);

  Map<String, dynamic> toJson() => _$UniDataToJson(this);
  
  // Keep fromMap and toMap for backward compatibility
  factory UniData.fromMap(Map<String, dynamic> map) =>
      UniData.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}

typedef DataResonseunivarsity = PaginationModel<UniData>;
