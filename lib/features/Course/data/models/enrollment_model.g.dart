// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollmentModel _$EnrollmentModelFromJson(Map json) => EnrollmentModel(
      id: const IntConverter().fromJson(json['id']),
      student: const NullableIntConverter().fromJson(json['student']),
      studentName:
          const NullableStringConverter().fromJson(json['student_name']),
      course: const IntConverter().fromJson(json['course']),
      courseTitle: const StringConverter().fromJson(json['course_title']),
      courseImage:
          const NullableStringConverter().fromJson(json['course_image']),
      teacherName: const StringConverter().fromJson(json['teacher_name']),
      enrolledAt: const StringConverter().fromJson(json['enrolled_at']),
      status: const StringConverter().fromJson(json['status']),
      statusDisplay: const StringConverter().fromJson(json['status_display']),
      paymentStatus: const StringConverter().fromJson(json['payment_status']),
      paymentStatusDisplay:
          const StringConverter().fromJson(json['payment_status_display']),
      isPaid: const BoolConverter().fromJson(json['is_paid']),
      progressPercentage:
          const IntConverter().fromJson(json['progress_percentage']),
      isCompleted: const BoolConverter().fromJson(json['is_completed']),
      completedAt:
          const NullableStringConverter().fromJson(json['completed_at']),
      originalPrice:
          const NullableStringConverter().fromJson(json['original_price']),
      isFavorite: const BoolConverter().fromJson(json['is_favorite']),
    );

Map<String, dynamic> _$EnrollmentModelToJson(EnrollmentModel instance) =>
    <String, dynamic>{
      'id': const IntConverter().toJson(instance.id),
      'student': const NullableIntConverter().toJson(instance.student),
      'student_name':
          const NullableStringConverter().toJson(instance.studentName),
      'course': const IntConverter().toJson(instance.course),
      'course_title': const StringConverter().toJson(instance.courseTitle),
      'course_image':
          const NullableStringConverter().toJson(instance.courseImage),
      'teacher_name': const StringConverter().toJson(instance.teacherName),
      'enrolled_at': const StringConverter().toJson(instance.enrolledAt),
      'status': const StringConverter().toJson(instance.status),
      'status_display': const StringConverter().toJson(instance.statusDisplay),
      'payment_status': const StringConverter().toJson(instance.paymentStatus),
      'payment_status_display':
          const StringConverter().toJson(instance.paymentStatusDisplay),
      'is_paid': const BoolConverter().toJson(instance.isPaid),
      'progress_percentage':
          const IntConverter().toJson(instance.progressPercentage),
      'is_completed': const BoolConverter().toJson(instance.isCompleted),
      'completed_at':
          const NullableStringConverter().toJson(instance.completedAt),
      'original_price':
          const NullableStringConverter().toJson(instance.originalPrice),
      'is_favorite': const BoolConverter().toJson(instance.isFavorite),
    };
