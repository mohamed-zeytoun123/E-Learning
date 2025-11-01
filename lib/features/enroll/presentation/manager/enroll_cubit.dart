import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/enroll/data/models/params/create_rating_params.dart';
import 'package:e_learning/features/enroll/data/models/params/get_course_ratings_params.dart';
import 'package:e_learning/features/enroll/data/source/repo/enroll_repository.dart';
import 'package:e_learning/features/enroll/presentation/manager/enroll_state.dart';

class EnrollCubit extends Cubit<EnrollState> {
  final EnrollRepository repository;

  EnrollCubit({required this.repository}) : super(const EnrollState());

  //? ------------------------ Get My Courses ----------------------------
  Future<void> getMyCourses() async {
    emit(
      state.copyWith(
        getMyCoursesState: ResponseStatusEnum.loading,
        getMyCoursesError: null,
      ),
    );

    final result = await repository.getMyCoursesRepo();

    result.fold(
      (failure) => emit(
        state.copyWith(
          getMyCoursesState: ResponseStatusEnum.failure,
          getMyCoursesError: failure.message,
        ),
      ),
      (enrollments) => emit(
        state.copyWith(
          getMyCoursesState: ResponseStatusEnum.success,
          enrollments: enrollments,
          getMyCoursesError: null,
        ),
      ),
    );
  }

  //? ------------------------ Get Course Ratings ----------------------------
  Future<void> getCourseRatings(GetCourseRatingsParams params) async {
    emit(
      state.copyWith(
        getCourseRatingsState: ResponseStatusEnum.loading,
        getCourseRatingsError: null,
      ),
    );

    final result = await repository.getCourseRatingsRepo(params);

    result.fold(
      (failure) => emit(
        state.copyWith(
          getCourseRatingsState: ResponseStatusEnum.failure,
          getCourseRatingsError: failure.message,
        ),
      ),
      (ratingsResponse) => emit(
        state.copyWith(
          getCourseRatingsState: ResponseStatusEnum.success,
          courseRatingsResponse: ratingsResponse,
          getCourseRatingsError: null,
        ),
      ),
    );
  }

  //? ------------------------ Create Rating ----------------------------
  Future<void> createRating(CreateRatingParams params) async {
    emit(
      state.copyWith(
        createRatingState: ResponseStatusEnum.loading,
        createRatingError: null,
      ),
    );

    final result = await repository.createRatingRepo(params);

    result.fold(
      (failure) => emit(
        state.copyWith(
          createRatingState: ResponseStatusEnum.failure,
          createRatingError: failure.message,
        ),
      ),
      (rating) => emit(
        state.copyWith(
          createRatingState: ResponseStatusEnum.success,
          createdRating: rating,
          createRatingError: null,
        ),
      ),
    );
  }
}
