import 'dart:async';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/models/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/study_year_model.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_enum.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({required this.repo, this.authRepo}) : super(CourseState());
  final CourceseRepository repo;
  final AuthRepository? authRepo;
  Timer? _searchDebounceTimer;

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

    final Either<Failure, List<CategorieModel>> result =
        await repo.getFilterCategoriesRepo();

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
  Future<void> getCourses({int? categoryId}) async {
    emit(state.copyWith(
      coursesStatus: ResponseStatusEnum.loading,
      selectedCategoryId: categoryId,
    ));

    final result = await repo.getCoursesRepo(categoryId: categoryId);

    result.fold(
      (failure) {
        print('❌ CourseCubit: Failed to get courses - ${failure.message}');
        emit(
          state.copyWith(
            coursesStatus: ResponseStatusEnum.failure,
            coursesError: failure.message,
          ),
        );
      },
      (courses) {
        print('✅ CourseCubit: Successfully loaded ${courses.length} courses');
        print(
            '✅ CourseCubit: Emitting new state with ${courses.length} courses');
        final newState = state.copyWith(
          coursesStatus: ResponseStatusEnum.success,
          courses: courses,
          coursesError: null, // Clear any previous errors
        );
        print(
            '✅ CourseCubit: New state courses length: ${newState.courses?.length ?? 0}');
        emit(newState);
      },
    );
  }

  //?-------------------------------------------------
  //* Get Universities
  Future<void> getUniversities() async {
    if (authRepo == null) return;
    
    emit(state.copyWith(universitiesState: ResponseStatusEnum.loading));

    final result = await authRepo!.getUniversitiesRepo();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            universitiesState: ResponseStatusEnum.failure,
            universitiesError: failure.message,
          ),
        );
      },
      (universities) {
        emit(
          state.copyWith(
            universitiesState: ResponseStatusEnum.success,
            universities: universities,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------
  //* Get Study Years
  Future<void> getStudyYears() async {
    emit(state.copyWith(studyYearsStatus: ResponseStatusEnum.loading));

    // Convert enum to model list
    final studyYears = SchoolYear.values.map((year) {
      return StudyYearModel(
        id: year.number,
        name: 'Year ${year.number}', // Simple name, can be improved with localization
      );
    }).toList();

    emit(
      state.copyWith(
        studyYearsStatus: ResponseStatusEnum.success,
        studyYears: studyYears,
      ),
    );
  }

  //?-------------------------------------------------
  //* Apply Filters by IDs
  void applyFiltersByIds({
    int? categoryId,
    int? studyYear,
  }) {
    final filters = CourseFiltersModel(
      categoryId: categoryId,
      studyYear: studyYear,
    );

    emit(state.copyWith(coursefilters: filters));

    // Re-fetch courses with filters
    getCourses(categoryId: categoryId);
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

  //* Filter Courses by College
  List<CourseModel> filterCoursesByCollege(int collegeId) {
    final allCourses = state.courses ?? [];

    final filteredCourses =
        allCourses.where((course) => course.college == collegeId).toList();

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
  //* Search Courses with Debouncing
  void onSearchChanged(String query) {
    // Cancel previous timer if exists
    _searchDebounceTimer?.cancel();

    final trimmedQuery = query.trim();

    // If query is empty, show search history
    if (trimmedQuery.isEmpty) {
      emit(state.copyWith(
        searchQuery: null,
        searchResults: null,
        searchStatus: ResponseStatusEnum.initial,
      ));
      return;
    }

    // Update query immediately for UI feedback
    emit(state.copyWith(searchQuery: trimmedQuery));

    // Debounce: wait 350ms before executing search
    _searchDebounceTimer = Timer(const Duration(milliseconds: 350), () {
      searchCourses(query: trimmedQuery);
    });
  }

  //* Search Courses
  Future<void> searchCourses({
    String? query,
    int? collegeId,
    int? studyYear,
    int? categoryId,
    int? teacherId,
    String? ordering,
  }) async {
    // If no query and no filters, don't search
    if ((query == null || query.isEmpty) &&
        collegeId == null &&
        studyYear == null &&
        categoryId == null &&
        teacherId == null) {
      return;
    }

    emit(state.copyWith(
      searchStatus: ResponseStatusEnum.loading,
      searchQuery: query,
      searchError: null,
    ));

    final result = await repo.getCoursesRepo(
      categoryId: categoryId ?? state.selectedCategoryId,
      collegeId: collegeId,
      studyYear: studyYear,
      teacherId: teacherId,
      search: query,
      ordering: ordering ?? '-price', // Default ordering by price descending
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          searchStatus: ResponseStatusEnum.failure,
          searchError: failure.message,
          searchResults: [],
        ));
      },
      (courses) {
        // Add to search history if query is not empty
        if (query != null && query.isNotEmpty) {
          final updatedHistory = [
            query,
            ...state.searchHistory.where((item) => item != query),
          ].take(10).toList(); // Keep max 10 items

          emit(state.copyWith(
            searchStatus: ResponseStatusEnum.success,
            searchResults: courses,
            searchHistory: updatedHistory,
            searchError: null,
          ));
        } else {
          emit(state.copyWith(
            searchStatus: ResponseStatusEnum.success,
            searchResults: courses,
            searchError: null,
          ));
        }
      },
    );
  }

  //* Clear Search
  void clearSearch() {
    _searchDebounceTimer?.cancel();
    emit(state.copyWith(
      searchQuery: null,
      searchResults: null,
      searchStatus: ResponseStatusEnum.initial,
      searchError: null,
    ));
  }

  //* Remove from Search History
  void removeFromSearchHistory(String query) {
    final updatedHistory = state.searchHistory.where((item) => item != query).toList();
    emit(state.copyWith(searchHistory: updatedHistory));
  }

  //* Select from Search History
  void selectFromSearchHistory(String query) {
    searchCourses(query: query);
  }

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }

  //?-------------------------------------------------

  //* Get Chapters by Course
  Future<void> getChapters({required int courseId}) async {
    emit(state.copyWith(chaptersStatus: ResponseStatusEnum.loading));

    final result = await repo.getChaptersRepo(courseId: courseId);

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

  //?-------------------------------------------------}
}
