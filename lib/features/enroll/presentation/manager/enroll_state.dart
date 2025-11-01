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
  final Map<String, CourseRatingResponse>
  courseRatingsMap; // Changed to Map per course slug

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
    this.courseRatingsMap = const {}, // Changed to empty Map
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
    Map<String, CourseRatingResponse>? courseRatingsMap, // Changed parameter
    ResponseStatusEnum? createRatingState,
    String? createRatingError,
    CourseRatingModel? createdRating,
  }) {
    return EnrollState(
      getMyCoursesState: getMyCoursesState ?? this.getMyCoursesState,
      getMyCoursesError: getMyCoursesError,
      enrollments: enrollments ?? this.enrollments,
      getCourseRatingsState:
          getCourseRatingsState ?? this.getCourseRatingsState,
      getCourseRatingsError: getCourseRatingsError,
      courseRatingsMap:
          courseRatingsMap ?? this.courseRatingsMap, // Changed implementation
      createRatingState: createRatingState ?? this.createRatingState,
      createRatingError: createRatingError,
      createdRating: createdRating ?? this.createdRating,
    );
  }
}
