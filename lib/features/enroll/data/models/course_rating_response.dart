import 'package:e_learning/core/utils/json_converters.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_rating_response.g.dart';

@JsonSerializable()
class CourseRatingResponse {
  @IntConverter()
  final int count;
  
  @NullableStringConverter()
  final String? next;
  
  @NullableStringConverter()
  final String? previous;
  
  @JsonKey(name: 'total_pages')
  @IntConverter()
  final int totalPages;
  
  @JsonKey(name: 'current_page')
  @IntConverter()
  final int currentPage;
  
  @JsonKey(name: 'page_size')
  @IntConverter()
  final int pageSize;
  
  final List<CourseRatingModel> results;

  CourseRatingResponse({
    required this.count,
    this.next,
    this.previous,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.results,
  });

  factory CourseRatingResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseRatingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseRatingResponseToJson(this);
}

