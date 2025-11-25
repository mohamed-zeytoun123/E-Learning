import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/college_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_details_model.g.dart';

@JsonSerializable()
class CourseDetailsModel {
  @IntConverter()
  final int id;
  
  @StringConverter()
  final String title;
  
  @StringConverter()
  final String slug;
  
  @StringConverter()
  final String description;
  
  @NullableStringConverter()
  final String? image;
  
  @IntConverter()
  final int teacher;
  
  @JsonKey(name: 'teacher_name')
  @StringConverter()
  final String teacherName;
  
  @JsonKey(name: 'teacher_avatar')
  @NullableStringConverter()
  final String? teacherAvatar;
  
  @IntConverter()
  final int category;
  
  @JsonKey(name: 'category_detail')
  final CategorieModel categoryDetail;
  
  @IntConverter()
  final int college;
  
  @JsonKey(name: 'college_detail')
  final CollegeDetailModel collegeDetail;
  
  @JsonKey(name: 'study_year')
  @IntConverter()
  final int studyYear;
  
  @JsonKey(name: 'study_year_detail')
  final StudyYearModel studyYearDetail;
  
  @StringConverter()
  final String price;
  
  @StringConverter()
  final String status;
  
  @JsonKey(name: 'total_video_duration_hours')
  @DoubleConverter()
  final double totalVideoDurationHours;
  
  @JsonKey(name: 'total_quizzes_count')
  @IntConverter()
  final int totalQuizzesCount;
  
  @JsonKey(name: 'average_rating')
  @NullableDoubleConverter()
  final double? averageRating;
  
  @JsonKey(name: 'total_ratings')
  @DoubleConverter()
  final double totalRatings;
  
  @JsonKey(name: 'is_favorite')
  @BoolConverter()
  final bool isFavorite;
  
  @JsonKey(name: 'is_paid')
  @BoolConverter()
  final bool isPaid;
  
  @JsonKey(name: 'created_at')
  @DateTimeConverter()
  final DateTime createdAt;
  
  @JsonKey(name: 'updated_at')
  @DateTimeConverter()
  final DateTime updatedAt;

  CourseDetailsModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    this.image,
    required this.teacher,
    required this.teacherName,
    this.teacherAvatar,
    required this.category,
    required this.categoryDetail,
    required this.college,
    required this.collegeDetail,
    required this.studyYear,
    required this.studyYearDetail,
    required this.price,
    required this.status,
    required this.totalVideoDurationHours,
    required this.totalQuizzesCount,
    this.averageRating,
    required this.totalRatings,
    required this.isFavorite,
    required this.isPaid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailsModelToJson(this);
  
  // Keep fromMap and toMap for backward compatibility
  factory CourseDetailsModel.fromMap(Map<String, dynamic> map) =>
      CourseDetailsModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
  
  static CategorieModel _categorieFromJson(dynamic json) => CategorieModel.fromJson(json as Map<String, dynamic>);
  static Object _categorieToJson(CategorieModel object) => object.toJson();
  
  static CollegeDetailModel _collegeDetailFromJson(dynamic json) => CollegeDetailModel.fromJson(json as Map<String, dynamic>);
  static Object _collegeDetailToJson(CollegeDetailModel object) => object.toJson();
  
  static StudyYearModel _studyYearFromJson(dynamic json) => StudyYearModel.fromJson(json as Map<String, dynamic>);
  static Object _studyYearToJson(StudyYearModel object) => object.toJson();
}
