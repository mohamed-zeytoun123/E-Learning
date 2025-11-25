import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/Article/data/models/article_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:netwoek/mapper/base_model.dart';

part 'article_response_model.g.dart';

@JsonSerializable()
class ArticleResponseModel extends Model {
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

  final List<ArticleModel> results;

  ArticleResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory ArticleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleResponseModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory ArticleResponseModel.fromMap(Map<String, dynamic> map) =>
      ArticleResponseModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  @override
  Model fromJson(Map<String, dynamic> json) {
    return ArticleResponseModel.fromJson(json);
  }
}
