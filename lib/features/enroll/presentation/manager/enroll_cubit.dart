import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
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

    final result = await repository.getMyCourses();

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
}
