import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/Course/data/models/advertisment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'advertisement_response_model.g.dart';

@JsonSerializable()
class AdvertisementResponseModel {
  @IntConverter()
  final int count;
  
  @NullableStringConverter()
  final String? next;
  
  @NullableStringConverter()
  final String? previous;
  
  @JsonKey(name: 'total_pages')
  @IntConverter()
  final int totalPages;
  
  @JsonKey(name: 'current_page')
  @IntConverter()
  final int currentPage;
  
  @JsonKey(name: 'page_size')
  @IntConverter()
  final int pageSize;
  
  final List<AdvertisementModel> results;

  AdvertisementResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory AdvertisementResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertisementResponseModelToJson(this);
  
  // Keep fromMap and toMap for backward compatibility
  factory AdvertisementResponseModel.fromMap(Map<String, dynamic> map) =>
      AdvertisementResponseModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
