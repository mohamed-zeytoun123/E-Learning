import 'package:e_learning/core/utils/json_converters.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class CourseModel extends HiveObject {
  @HiveField(0)
  @IntConverter()
  final int id;

  @HiveField(1)
  @StringConverter()
  final String title;

  @HiveField(2)
  @StringConverter()
  final String slug;

  @HiveField(3)
  @NullableStringConverter()
  final String? image;

  @HiveField(4)
  @IntConverter()
  final int college;

  @HiveField(5)
  @JsonKey(name: 'college_name')
  @StringConverter()
  final String collegeName;

  @HiveField(6)
  @StringConverter()
  final String price;

  @HiveField(7)
  @JsonKey(name: 'average_rating')
  @NullableDoubleConverter()
  final double? averageRating;

  @HiveField(8)
  @JsonKey(name: 'total_video_duration_hours')
  @DoubleConverter()
  final double totalVideoDurationHours;

  @HiveField(9)
  @JsonKey(name: 'is_favorite')
  @BoolConverter()
  final bool isFavorite;

  CourseModel({
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

  CourseModel copyWith({
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
    return CourseModel(
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

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory CourseModel.fromMap(Map<String, dynamic> map) =>
      CourseModel.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}

