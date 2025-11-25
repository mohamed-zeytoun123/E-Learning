// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailsModel _$CourseDetailsModelFromJson(Map json) => CourseDetailsModel(
      id: const IntConverter().fromJson(json['id']),
      title: const StringConverter().fromJson(json['title']),
      slug: const StringConverter().fromJson(json['slug']),
      description: const StringConverter().fromJson(json['description']),
      image: const NullableStringConverter().fromJson(json['image']),
      teacher: const IntConverter().fromJson(json['teacher']),
      teacherName: const StringConverter().fromJson(json['teacher_name']),
      teacherAvatar:
          const NullableStringConverter().fromJson(json['teacher_avatar']),
      category: const IntConverter().fromJson(json['category']),
      categoryDetail: CategorieModel.fromJson(
          Map<String, dynamic>.from(json['category_detail'] as Map)),
      college: const IntConverter().fromJson(json['college']),
      collegeDetail: CollegeDetailModel.fromJson(
          Map<String, dynamic>.from(json['college_detail'] as Map)),
      studyYear: const IntConverter().fromJson(json['study_year']),
      studyYearDetail: StudyYearModel.fromJson(
          Map<String, dynamic>.from(json['study_year_detail'] as Map)),
      price: const StringConverter().fromJson(json['price']),
      status: const StringConverter().fromJson(json['status']),
      totalVideoDurationHours:
          const DoubleConverter().fromJson(json['total_video_duration_hours']),
      totalQuizzesCount:
          const IntConverter().fromJson(json['total_quizzes_count']),
      averageRating:
          const NullableDoubleConverter().fromJson(json['average_rating']),
      totalRatings: const DoubleConverter().fromJson(json['total_ratings']),
      isFavorite: const BoolConverter().fromJson(json['is_favorite']),
      isPaid: const BoolConverter().fromJson(json['is_paid']),
      createdAt: const DateTimeConverter().fromJson(json['created_at']),
      updatedAt: const DateTimeConverter().fromJson(json['updated_at']),
    );

Map<String, dynamic> _$CourseDetailsModelToJson(CourseDetailsModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'title': const StringConverter().toJson(instance.title),
      'slug': const StringConverter().toJson(instance.slug),
      'description': const StringConverter().toJson(instance.description),
      'image': const NullableStringConverter().toJson(instance.image),
      'teacher': const IntConverter().toJson(instance.teacher),
      'teacher_name': const StringConverter().toJson(instance.teacherName),
      'teacher_avatar':
          const NullableStringConverter().toJson(instance.teacherAvatar),
      'category': const IntConverter().toJson(instance.category),
      'category_detail': instance.categoryDetail,
      'college': const IntConverter().toJson(instance.college),
      'college_detail': instance.collegeDetail,
      'study_year': const IntConverter().toJson(instance.studyYear),
      'study_year_detail': instance.studyYearDetail,
      'price': const StringConverter().toJson(instance.price),
      'status': const StringConverter().toJson(instance.status),
      'total_video_duration_hours':
          const DoubleConverter().toJson(instance.totalVideoDurationHours),
      'total_quizzes_count':
          const IntConverter().toJson(instance.totalQuizzesCount),
      'average_rating':
          const NullableDoubleConverter().toJson(instance.averageRating),
      'total_ratings': const DoubleConverter().toJson(instance.totalRatings),
      'is_favorite': const BoolConverter().toJson(instance.isFavorite),
      'is_paid': const BoolConverter().toJson(instance.isPaid),
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'updated_at': const DateTimeConverter().toJson(instance.updatedAt),
    };
