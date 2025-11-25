import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teacher_course_model.g.dart';

@JsonSerializable()
class TeacherCourseModel {
  @IntConverter()
  final int id;
  
  @StringConverter()
  final String title;
  
  @StringConverter()
  final String slug;
  
  @NullableStringConverter()
  final String? image;
  
  @IntConverter()
  final int college;
  
  @JsonKey(name: 'college_name')
  @StringConverter()
  final String collegeName;
  
  @StringConverter()
  final String price;
  
  @NullableDoubleConverter()
  final double? averageRating;
  
  @JsonKey(name: 'total_video_duration_hours')
  @DoubleConverter()
  final double totalVideoDurationHours;
  
  @JsonKey(name: 'is_favorite')
  @BoolConverter()
  final bool isFavorite;
  
  TeacherCourseModel({
    required this.id,
    required this.title,
    required this.slug,
    this.image,
    required this.college,
    required this.collegeName,
    required this.price,
    this.averageRating,
    required this.totalVideoDurationHours,
    required this.isFavorite,
  });

  TeacherCourseModel copyWith({
    int? id,
    String? title,
    String? slug,
    String? image,
    int? college,
    String? collegeName,
    String? price,
    double? averageRating,
    double? totalVideoDurationHours,
    bool? isFavorite,
  }) {
    return TeacherCourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      college: college ?? this.college,
      collegeName: collegeName ?? this.collegeName,
      price: price ?? this.price,
      averageRating: averageRating ?? this.averageRating,
      totalVideoDurationHours:
          totalVideoDurationHours ?? this.totalVideoDurationHours,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory TeacherCourseModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherCourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherCourseModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory TeacherCourseModel.fromMap(Map<String, dynamic> map) =>
      TeacherCourseModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
