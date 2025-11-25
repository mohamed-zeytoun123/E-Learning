// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherCourseModel _$TeacherCourseModelFromJson(Map json) => TeacherCourseModel(
      id: const IntConverter().fromJson(json['id']),
      title: const StringConverter().fromJson(json['title']),
      slug: const StringConverter().fromJson(json['slug']),
      image: const NullableStringConverter().fromJson(json['image']),
      college: const IntConverter().fromJson(json['college']),
      collegeName: const StringConverter().fromJson(json['college_name']),
      price: const StringConverter().fromJson(json['price']),
      averageRating:
          const NullableDoubleConverter().fromJson(json['averageRating']),
      totalVideoDurationHours:
          const DoubleConverter().fromJson(json['total_video_duration_hours']),
      isFavorite: const BoolConverter().fromJson(json['is_favorite']),
    );

Map<String, dynamic> _$TeacherCourseModelToJson(TeacherCourseModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'title': const StringConverter().toJson(instance.title),
      'slug': const StringConverter().toJson(instance.slug),
      'image': const NullableStringConverter().toJson(instance.image),
      'college': const IntConverter().toJson(instance.college),
      'college_name': const StringConverter().toJson(instance.collegeName),
      'price': const StringConverter().toJson(instance.price),
      'averageRating':
          const NullableDoubleConverter().toJson(instance.averageRating),
      'total_video_duration_hours':
          const DoubleConverter().toJson(instance.totalVideoDurationHours),
      'is_favorite': const BoolConverter().toJson(instance.isFavorite),
    };
