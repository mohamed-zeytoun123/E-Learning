// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map json) => ArticleModel(
      id: const IntConverter().fromJson(json['id']),
      title: const StringConverter().fromJson(json['title']),
      slug: const StringConverter().fromJson(json['slug']),
      content: const NullableStringConverter().fromJson(json['content']),
      summary: const NullableStringConverter().fromJson(json['summary']),
      status: const StringConverter().fromJson(json['status']),
      author: const IntConverter().fromJson(json['author']),
      authorName: const StringConverter().fromJson(json['author_name']),
      category: const IntConverter().fromJson(json['category']),
      categoryName: const StringConverter().fromJson(json['category_name']),
      readingTime: const StringConverter().fromJson(json['reading_time']),
      metaDescription:
          const NullableStringConverter().fromJson(json['meta_description']),
      image: const NullableStringConverter().fromJson(json['image']),
      createdAt: const DateTimeConverter().fromJson(json['created_at']),
      updatedAt: const DateTimeConverter().fromJson(json['updated_at']),
      publishedAt:
          const NullableDateTimeConverter().fromJson(json['published_at']),
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'title': const StringConverter().toJson(instance.title),
      'slug': const StringConverter().toJson(instance.slug),
      'content': const NullableStringConverter().toJson(instance.content),
      'summary': const NullableStringConverter().toJson(instance.summary),
      'status': const StringConverter().toJson(instance.status),
      'author': const IntConverter().toJson(instance.author),
      'author_name': const StringConverter().toJson(instance.authorName),
      'category': const IntConverter().toJson(instance.category),
      'category_name': const StringConverter().toJson(instance.categoryName),
      'reading_time': const StringConverter().toJson(instance.readingTime),
      'meta_description':
          const NullableStringConverter().toJson(instance.metaDescription),
      'image': const NullableStringConverter().toJson(instance.image),
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'updated_at': const DateTimeConverter().toJson(instance.updatedAt),
      'published_at':
          const NullableDateTimeConverter().toJson(instance.publishedAt),
    };
