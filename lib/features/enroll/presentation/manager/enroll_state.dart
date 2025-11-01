import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_model.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_response.dart';
import 'package:e_learning/features/enroll/data/models/enrollment_model.dart';

class EnrollState {
  //* Get My Courses
  final ResponseStatusEnum getMyCoursesState;
  final String? getMyCoursesError;
  final List<EnrollmentModel> enrollments;

  //* Get Course Ratings
  final ResponseStatusEnum getCourseRatingsState;
  final String? getCourseRatingsError;
  final CourseRatingResponse? courseRatingsResponse;

  //* Create Rating
  final ResponseStatusEnum createRatingState;
  final String? createRatingError;
  final CourseRatingModel? createdRating;

  const EnrollState({
    this.getMyCoursesState = ResponseStatusEnum.initial,
    this.getMyCoursesError,
    this.enrollments = const [],
    this.getCourseRatingsState = ResponseStatusEnum.initial,
    this.getCourseRatingsError,
    this.courseRatingsResponse,
    this.createRatingState = ResponseStatusEnum.initial,
    this.createRatingError,
    this.createdRating,
  });

  EnrollState copyWith({
    ResponseStatusEnum? getMyCoursesState,
    String? getMyCoursesError,
    List<EnrollmentModel>? enrollments,
    ResponseStatusEnum? getCourseRatingsState,
    String? getCourseRatingsError,
    CourseRatingResponse? courseRatingsResponse,
    ResponseStatusEnum? createRatingState,
    String? createRatingError,
    CourseRatingModel? createdRating,
  }) {
    return EnrollState(
      getMyCoursesState: getMyCoursesState ?? this.getMyCoursesState,
      getMyCoursesError: getMyCoursesError,
      enrollments: enrollments ?? this.enrollments,
      getCourseRatingsState: getCourseRatingsState ?? this.getCourseRatingsState,
      getCourseRatingsError: getCourseRatingsError,
      courseRatingsResponse: courseRatingsResponse ?? this.courseRatingsResponse,
      createRatingState: createRatingState ?? this.createRatingState,
      createRatingError: createRatingError,
      createdRating: createdRating ?? this.createdRating,
    );
  }
}
