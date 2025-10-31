import 'dart:developer';

import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';
import 'package:e_learning/features/course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({required this.repo}) : super(CourseState());
  final CourceseRepository repo;

  //?-------------------------------------------------
  //* Change Selected Index
  void changeSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  List<CourseModel> getCoursesBySelectedCollege() {
    final selectedIndex = state.selectedIndex;
    final allCourses = state.courses ?? [];
    final colleges = state.colleges ?? [];

    if (selectedIndex == 0) {
      return allCourses;
    }

    final selectedCollegeIndex = selectedIndex - 1;
    if (selectedCollegeIndex < 0 || selectedCollegeIndex >= colleges.length) {
      return [];
    }

    final selectedCollegeId = colleges[selectedCollegeIndex].id;

    return allCourses
        .where((course) => course.college == selectedCollegeId)
        .toList();
  }

  //?-----------------------------------------------------------------------------

  //* Get Filter Categories
  Future<void> getFilterCategories() async {
    emit(state.copyWith(categoriesStatus: ResponseStatusEnum.loading));

    final Either<Failure, List<CategorieModel>> result = await repo
        .getFilterCategoriesRepo();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            categoriesStatus: ResponseStatusEnum.failure,
            categoriesError: failure.message,
          ),
        );
      },
      (categories) {
        emit(
          state.copyWith(
            categoriesStatus: ResponseStatusEnum.success,
            categories: categories,
          ),
        );
      },
    );
  }

  //?-----------------------------------------------------------------------------

  //* Get Courses
  Future<void> getCourses({
    int? collegeId,
    int? studyYear,
    int? categoryId,
    int? teacherId,
    String? search,
    String? ordering,
  }) async {
    emit(state.copyWith(coursesStatus: ResponseStatusEnum.loading));
    log('Applying filters Cubit : college=$categoryId, studyYear=$studyYear');
    final result = await repo.getCoursesRepo(
      collegeId: collegeId,
      studyYear: studyYear,
      categoryId: categoryId,
      teacherId: teacherId,
      search: search,
      ordering: ordering,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            coursesStatus: ResponseStatusEnum.failure,
            coursesError: failure.message,
          ),
        );
      },
      (courses) {
        emit(
          state.copyWith(
            coursesStatus: ResponseStatusEnum.success,
            courses: courses,
            coursesError: null,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------

  //* Get Colleges
  Future<void> getColleges() async {
    emit(state.copyWith(collegesStatus: ResponseStatusEnum.loading));

    final result = await repo.getCollegesRepo();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            collegesStatus: ResponseStatusEnum.failure,
            collegesError: failure.message,
          ),
        );
      },
      (colleges) {
        emit(
          state.copyWith(
            collegesStatus: ResponseStatusEnum.success,
            colleges: colleges,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------

  Future<void> applyFilters(CourseFiltersModel filters) async {
    try {
      // تحديث الفلاتر في الـ state
      emit(state.copyWith(coursefilters: filters));

      // حفظ الفلاتر بالكاش (لو عندك طريقة للكاش)
      // await local.saveCourseFilters(filters);

      // استدعاء getCourses مع تحويل الفلاتر للباراميترات المناسبة
      await getCourses(
        collegeId: filters.collegeId,

        studyYear: filters.studyYear,
      );
    } catch (e) {
      log('Error in applyFilters: $e');
    }
  }

  //?-------------------------------------------------

  //* Filter Courses by College
  List<CourseModel> filterCoursesByCollege(int collegeId) {
    final allCourses = state.courses ?? [];

    final filteredCourses = allCourses
        .where((course) => course.college == collegeId)
        .toList();

    return filteredCourses;
  }

  //?-------------------------------------------------
  //* Get Course Details by Slug
  Future<void> getCourseDetails({required String slug}) async {
    emit(state.copyWith(courseDetailsStatus: ResponseStatusEnum.loading));

    final result = await repo.getCourseDetailsRepo(courseSlug: slug);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            courseDetailsStatus: ResponseStatusEnum.failure,
            courseDetailsError: failure.message,
          ),
        );
      },
      (courseDetails) {
        emit(
          state.copyWith(
            courseDetailsStatus: ResponseStatusEnum.success,
            courseDetails: courseDetails,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------

  //* Get Chapters by Course
  Future<void> getChapters({required String courseSlug}) async {
    emit(state.copyWith(chaptersStatus: ResponseStatusEnum.loading));

    final result = await repo.getChaptersRepo(courseSlug: courseSlug);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            chaptersStatus: ResponseStatusEnum.failure,
            chaptersError: failure.message,
          ),
        );
      },
      (chapters) {
        emit(
          state.copyWith(
            chaptersStatus: ResponseStatusEnum.success,
            chapters: chapters,
          ),
        );
      },
    );
  }

  //?--------------------------------------------------------

  //* Get Universities
  Future<void> getUniversities() async {
    emit(
      state.copyWith(
        universitiesState: ResponseStatusEnum.loading,
        universitiesError: null,
      ),
    );

    final result = await repo.getUniversitiesRepo();

    result.fold(
      (failure) => emit(
        state.copyWith(
          universitiesState: ResponseStatusEnum.failure,
          universitiesError: failure.message,
        ),
      ),
      (universities) => emit(
        state.copyWith(
          universitiesState: ResponseStatusEnum.success,
          universities: universities,
        ),
      ),
    );
  }

  //?-------------------------------------------------
}
