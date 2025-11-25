import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enrollment_model.g.dart';

@JsonSerializable()
class EnrollmentModel {
  @IntConverter()
  final int id;
  
  @NullableIntConverter()
  final int? student;
  
  @JsonKey(name: 'student_name')
  @NullableStringConverter()
  final String? studentName;
  
  @IntConverter()
  final int course;
  
  @JsonKey(name: 'course_title')
  @StringConverter()
  final String courseTitle;
  
  @JsonKey(name: 'course_image')
  @NullableStringConverter()
  final String? courseImage;
  
  @JsonKey(name: 'teacher_name')
  @StringConverter()
  final String teacherName;
  
  @JsonKey(name: 'enrolled_at')
  @StringConverter()
  final String enrolledAt;
  
  @StringConverter()
  final String status;
  
  @JsonKey(name: 'status_display')
  @StringConverter()
  final String statusDisplay;
  
  @JsonKey(name: 'payment_status')
  @StringConverter()
  final String paymentStatus;
  
  @JsonKey(name: 'payment_status_display')
  @StringConverter()
  final String paymentStatusDisplay;
  
  @JsonKey(name: 'is_paid')
  @BoolConverter()
  final bool isPaid;
  
  @JsonKey(name: 'progress_percentage')
  @IntConverter()
  final int progressPercentage;
  
  @JsonKey(name: 'is_completed')
  @BoolConverter()
  final bool isCompleted;
  
  @JsonKey(name: 'completed_at')
  @NullableStringConverter()
  final String? completedAt;
  
  @JsonKey(name: 'original_price')
  @NullableStringConverter()
  final String? originalPrice;
  
  @JsonKey(name: 'is_favorite')
  @BoolConverter()
  final bool isFavorite;

  EnrollmentModel({
    required this.id,
    this.student,
    this.studentName,
    required this.course,
    required this.courseTitle,
    this.courseImage,
    required this.teacherName,
    required this.enrolledAt,
    required this.status,
    required this.statusDisplay,
    required this.paymentStatus,
    required this.paymentStatusDisplay,
    required this.isPaid,
    required this.progressPercentage,
    required this.isCompleted,
    this.completedAt,
    this.originalPrice,
    required this.isFavorite,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollmentModelToJson(this);
}
