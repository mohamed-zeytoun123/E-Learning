// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map json) => RatingModel(
      id: const IntConverter().fromJson(json['id']),
      studentName: const StringConverter().fromJson(json['student_name']),
      studentImage:
          const NullableStringConverter().fromJson(json['student_image']),
      rating: const IntConverter().fromJson(json['rating']),
      comment: const StringConverter().fromJson(json['comment']),
      isFeatured: const BoolConverter().fromJson(json['is_featured']),
      createdAt: const DateTimeConverter().fromJson(json['created_at']),
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'student_name': const StringConverter().toJson(instance.studentName),
      'student_image':
          const NullableStringConverter().toJson(instance.studentImage),
      'rating': const IntConverter().toJson(instance.rating),
      'comment': const StringConverter().toJson(instance.comment),
      'is_featured': const BoolConverter().toJson(instance.isFeatured),
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
    };
