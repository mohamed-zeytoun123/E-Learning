import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Teacher/data/source/repo/teacher_repository.dart';
import 'package:e_learning/features/Teacher/presentation/manager/teacher_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit({required this.repo}) : super(TeacherState());
  final TeacherRepository repo;

  //?-------------------------------------------------

  //* Get Teachers
  Future<void> getTeachers({
    int? page,
    int? pageSize,
    String? search,
  }) async {
    emit(state.copyWith(teachersStatus: ResponseStatusEnum.loading));

    final result = await repo.getTeachersRepo(
      page: page,
      pageSize: pageSize,
      search: search,
    );

    result.fold(
      (failure) {
        print('❌ TeacherCubit: Failed to get teachers - ${failure.message}');
        emit(
          state.copyWith(
            teachersStatus: ResponseStatusEnum.failure,
            teachersError: failure.message,
          ),
        );
      },
      (teacherResponse) {
        print(
            '✅ TeacherCubit: Successfully loaded ${teacherResponse.results.length} teachers');
        final newState = state.copyWith(
          teachersStatus: ResponseStatusEnum.success,
          teachers: teacherResponse.results,
          teachersError: null,
          currentPage: teacherResponse.currentPage,
          totalPages: teacherResponse.totalPages,
          count: teacherResponse.count,
          hasNextPage: teacherResponse.next != null,
          hasPreviousPage: teacherResponse.previous != null,
        );
        emit(newState);
      },
    );
  }

  //?-------------------------------------------------

  //* Load More Teachers (Next Page)
  Future<void> loadMoreTeachers() async {
    if (!state.hasNextPage ||
        state.teachersStatus == ResponseStatusEnum.loading) {
      return;
    }

    final nextPage = (state.currentPage ?? 1) + 1;
    emit(state.copyWith(teachersStatus: ResponseStatusEnum.loading));

    final result = await repo.getTeachersRepo(page: nextPage);

    result.fold(
      (failure) {
        print(
            '❌ TeacherCubit: Failed to load more teachers - ${failure.message}');
        emit(
          state.copyWith(
            teachersStatus: ResponseStatusEnum.failure,
            teachersError: failure.message,
          ),
        );
      },
      (teacherResponse) {
        final currentTeachers = state.teachers ?? [];
        final newTeachers = [...currentTeachers, ...teacherResponse.results];
        print(
            '✅ TeacherCubit: Loaded ${teacherResponse.results.length} more teachers. Total: ${newTeachers.length}');
        final newState = state.copyWith(
          teachersStatus: ResponseStatusEnum.success,
          teachers: newTeachers,
          teachersError: null,
          currentPage: teacherResponse.currentPage,
          totalPages: teacherResponse.totalPages,
          count: teacherResponse.count,
          hasNextPage: teacherResponse.next != null,
          hasPreviousPage: teacherResponse.previous != null,
        );
        emit(newState);
      },
    );
  }

  //?-------------------------------------------------

  //* Refresh Teachers
  Future<void> refreshTeachers({String? search}) async {
    emit(state.copyWith(teachersStatus: ResponseStatusEnum.loading));

    final result = await repo.getTeachersRepo(search: search);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            teachersStatus: ResponseStatusEnum.failure,
            teachersError: failure.message,
          ),
        );
      },
      (teacherResponse) {
        final newState = state.copyWith(
          teachersStatus: ResponseStatusEnum.success,
          teachers: teacherResponse.results,
          teachersError: null,
          currentPage: teacherResponse.currentPage,
          totalPages: teacherResponse.totalPages,
          count: teacherResponse.count,
          hasNextPage: teacherResponse.next != null,
          hasPreviousPage: teacherResponse.previous != null,
        );
        emit(newState);
      },
    );
  }

  //?-------------------------------------------------
}
