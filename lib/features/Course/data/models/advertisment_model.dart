import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'advertisment_model.g.dart';

@JsonSerializable()
class AdvertisementModel {
  @IntConverter()
  final int id;
  
  @StringConverter()
  @JsonKey(name: 'image_url')
  final String imageUrl;
  
  @BoolConverter()
  @JsonKey(name: 'is_currently_active')
  final bool isCurrentlyActive;
  
  @DateTimeConverter()
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  
  AdvertisementModel({
    required this.id,
    required this.imageUrl,
    required this.isCurrentlyActive,
    required this.createdAt,
  });

  AdvertisementModel copyWith({
    int? id,
    String? imageUrl,
    bool? isCurrentlyActive,
    DateTime? createdAt,
  }) {
    return AdvertisementModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      isCurrentlyActive: isCurrentlyActive ?? this.isCurrentlyActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertisementModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory AdvertisementModel.fromMap(Map<String, dynamic> map) =>
      AdvertisementModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}

