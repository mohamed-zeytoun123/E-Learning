import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationModel<T> {
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
  final List<T> results;

  PaginationModel({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$PaginationModelToJson(this, toJsonT);
}
