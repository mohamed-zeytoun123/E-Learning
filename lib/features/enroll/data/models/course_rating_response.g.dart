// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseRatingResponse _$CourseRatingResponseFromJson(Map json) =>
    CourseRatingResponse(
      count: const IntConverter().fromJson(json['count']),
      next: const NullableStringConverter().fromJson(json['next']),
      previous: const NullableStringConverter().fromJson(json['previous']),
      totalPages: const IntConverter().fromJson(json['total_pages']),
      currentPage: const IntConverter().fromJson(json['current_page']),
      pageSize: const IntConverter().fromJson(json['page_size']),
      results: (json['results'] as List<dynamic>)
          .map((e) =>
              CourseRatingModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$CourseRatingResponseToJson(
        CourseRatingResponse instance) =>
    <String, dynamic>{
      'count': const IntConverter().toJson(instance.count),
      'next': const NullableStringConverter().toJson(instance.next),
      'previous': const NullableStringConverter().toJson(instance.previous),
      'total_pages': const IntConverter().toJson(instance.totalPages),
      'current_page': const IntConverter().toJson(instance.currentPage),
      'page_size': const IntConverter().toJson(instance.pageSize),
      'results': instance.results,
    };
