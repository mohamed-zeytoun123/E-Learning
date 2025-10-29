import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/enroll/data/models/enrollment_model.dart';

class EnrollState {
  //* Get My Courses
  final ResponseStatusEnum getMyCoursesState;
  final String? getMyCoursesError;
  final List<EnrollmentModel> enrollments;

  const EnrollState({
    this.getMyCoursesState = ResponseStatusEnum.initial,
    this.getMyCoursesError,
    this.enrollments = const [],
  });

  EnrollState copyWith({
    ResponseStatusEnum? getMyCoursesState,
    String? getMyCoursesError,
    List<EnrollmentModel>? enrollments,
  }) {
    return EnrollState(
      getMyCoursesState: getMyCoursesState ?? this.getMyCoursesState,
      getMyCoursesError: getMyCoursesError,
      enrollments: enrollments ?? this.enrollments,
    );
  }
}
