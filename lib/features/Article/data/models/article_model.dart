import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:netwoek/mapper/base_model.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends Model {
  @IntConverter()
  final int id;

  @StringConverter()
  final String title;

  @StringConverter()
  final String slug;

  @NullableStringConverter()
  final String? content;

  @NullableStringConverter()
  final String? summary;

  @StringConverter()
  final String status;

  @IntConverter()
  final int author;

  @JsonKey(name: 'author_name')
  @StringConverter()
  final String authorName;

  @IntConverter()
  final int category;

  @JsonKey(name: 'category_name')
  @StringConverter()
  final String categoryName;

  @JsonKey(name: 'reading_time')
  @StringConverter()
  final String readingTime;

  @JsonKey(name: 'meta_description')
  @NullableStringConverter()
  final String? metaDescription;

  @NullableStringConverter()
  final String? image;

  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  @DateTimeConverter()
  final DateTime updatedAt;

  @JsonKey(name: 'published_at')
  @NullableDateTimeConverter()
  final DateTime? publishedAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.slug,
    this.content,
    this.summary,
    required this.status,
    required this.author,
    required this.authorName,
    required this.category,
    required this.categoryName,
    required this.readingTime,
    this.metaDescription,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    this.publishedAt,
  });

  ArticleModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? content,
    String? summary,
    String? status,
    int? author,
    String? authorName,
    int? category,
    String? categoryName,
    String? readingTime,
    String? metaDescription,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      content: content ?? this.content,
      summary: summary ?? this.summary,
      status: status ?? this.status,
      author: author ?? this.author,
      authorName: authorName ?? this.authorName,
      category: category ?? this.category,
      categoryName: categoryName ?? this.categoryName,
      readingTime: readingTime ?? this.readingTime,
      metaDescription: metaDescription ?? this.metaDescription,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory ArticleModel.fromMap(Map<String, dynamic> map) =>
      ArticleModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  @override
  Model fromJson(Map<String, dynamic> json) {
    return ArticleModel.fromJson(json);
  }
}
