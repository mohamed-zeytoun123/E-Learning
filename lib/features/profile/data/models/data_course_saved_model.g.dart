// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_course_saved_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCourseSaved _$DataCourseSavedFromJson(Map json) => DataCourseSaved(
      id: const IntConverter().fromJson(json['id']),
      title: const StringConverter().fromJson(json['title']),
      totalRating: const IntConverter().fromJson(json['total_ratings']),
      image: const NullableStringConverter().fromJson(json['image']),
      college: const IntConverter().fromJson(json['college']),
      collegeName: const StringConverter().fromJson(json['college_name']),
      price: const StringConverter().fromJson(json['price']),
      averageRating:
          const NullableDoubleConverter().fromJson(json['average_rating']),
      totalVideoDurationHours:
          const DoubleConverter().fromJson(json['total_video_duration_hours']),
      isFavorite: const BoolConverter().fromJson(json['is_favorite']),
    );

Map<String, dynamic> _$DataCourseSavedToJson(DataCourseSaved instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'title': const StringConverter().toJson(instance.title),
      'total_ratings': const IntConverter().toJson(instance.totalRating),
      'image': const NullableStringConverter().toJson(instance.image),
      'college': const IntConverter().toJson(instance.college),
      'college_name': const StringConverter().toJson(instance.collegeName),
      'price': const StringConverter().toJson(instance.price),
      'average_rating':
          const NullableDoubleConverter().toJson(instance.averageRating),
      'total_video_duration_hours':
          const DoubleConverter().toJson(instance.totalVideoDurationHours),
      'is_favorite': const BoolConverter().toJson(instance.isFavorite),
    };
