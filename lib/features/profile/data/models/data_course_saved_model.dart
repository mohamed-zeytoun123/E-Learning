import 'package:e_learning/core/model/paginated_model.dart';
import 'package:e_learning/core/utils/json_converters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_course_saved_model.g.dart';

@JsonSerializable()
class DataCourseSaved {
  @IntConverter()
  final int id;

  @StringConverter()
  final String title;

  @JsonKey(name: 'total_ratings')
  @IntConverter()
  final int totalRating;

  @NullableStringConverter()
  final String? image;

  @IntConverter()
  final int college;

  @JsonKey(name: 'college_name')
  @StringConverter()
  final String collegeName;

  @StringConverter()
  final String price;

  @JsonKey(name: 'average_rating')
  @NullableDoubleConverter()
  final double? averageRating;

  @JsonKey(name: 'total_video_duration_hours')
  @DoubleConverter()
  final double totalVideoDurationHours;

  @JsonKey(name: 'is_favorite')
  @BoolConverter()
  final bool isFavorite;

  DataCourseSaved({
    required this.id,
    required this.title,
    required this.totalRating,
    required this.image,
    required this.college,
    required this.collegeName,
    required this.price,
    required this.averageRating,
    required this.totalVideoDurationHours,
    required this.isFavorite,
  });

  DataCourseSaved copyWith({
    int? id,
    String? title,
    int? totalRating,
    String? image,
    int? college,
    String? collegeName,
    String? price,
    double? averageRating,
    double? totalVideoDurationHours,
    bool? isFavorite,
  }) =>
      DataCourseSaved(
        id: id ?? this.id,
        title: title ?? this.title,
        totalRating: totalRating ?? this.totalRating,
        image: image ?? this.image,
        college: college ?? this.college,
        collegeName: collegeName ?? this.collegeName,
        price: price ?? this.price,
        averageRating: averageRating ?? this.averageRating,
        totalVideoDurationHours:
            totalVideoDurationHours ?? this.totalVideoDurationHours,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  factory DataCourseSaved.fromJson(Map<String, dynamic> json) =>
      _$DataCourseSavedFromJson(json);

  Map<String, dynamic> toJson() => _$DataCourseSavedToJson(this);

  // Keep fromMap and toMap for backward compatibility
  factory DataCourseSaved.fromMap(Map<String, dynamic> map) =>
      DataCourseSaved.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}

typedef DataResponseSaveCoursesPagination = PaginationModel<DataCourseSaved>;
