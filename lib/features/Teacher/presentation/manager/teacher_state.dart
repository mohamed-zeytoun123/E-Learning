import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';

class TeacherState {
  //?---------------------------------------------------------------

  //* Get Teachers
  final List<TeacherModel>? teachers;
  final ResponseStatusEnum teachersStatus;
  final String? teachersError;

  //* Pagination Info
  final int? currentPage;
  final int? totalPages;
  final int? count;
  final bool hasNextPage;
  final bool hasPreviousPage;

  //?----------------------------------------------------------------
  TeacherState({
    //* Get Teachers
    this.teachers,
    this.teachersStatus = ResponseStatusEnum.initial,
    this.teachersError,

    //* Pagination Info
    this.currentPage,
    this.totalPages,
    this.count,
    this.hasNextPage = false,
    this.hasPreviousPage = false,
  });

  //?------------------------------------------------------------------

  TeacherState copyWith({
    //* Get Teachers
    List<TeacherModel>? teachers,
    ResponseStatusEnum? teachersStatus,
    String? teachersError,

    //* Pagination Info
    int? currentPage,
    int? totalPages,
    int? count,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) {
    return TeacherState(
      //* Get Teachers
      teachers: teachers ?? this.teachers,
      teachersStatus: teachersStatus ?? this.teachersStatus,
      teachersError: teachersError ?? this.teachersError,

      //* Pagination Info
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      count: count ?? this.count,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
    );
  }

  //?-------------------------------------------------
}
