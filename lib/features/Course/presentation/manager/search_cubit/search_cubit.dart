import 'dart:async';
import 'dart:developer';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';
import 'package:e_learning/features/Teacher/data/source/repo/teacher_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/search_cubit/search_state.dart';
import 'package:e_learning/features/Article/data/models/article_model/article_model.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';
import 'package:e_learning/features/Course/data/models/course_model/course_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  final CourceseRepository courseRepository;
  final ArticleRepository articleRepository;
  final TeacherRepository teacherRepository;
  Timer? _debounce;

  SearchCubit({
    required this.courseRepository,
    required this.articleRepository,
    required this.teacherRepository,
  }) : super(SearchState());

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  //?-------------------------------------------------
  //* On Search Changed (with debounce)
  void onSearchChanged(String query) {
    // Cancel previous debounce timer if active
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // If query is empty, show history and don't call API
    if (query.trim().isEmpty) {
      emit(
        state.copyWith(
          searchQuery: null,
          showHistory: true, // Show search history
          // Don't change status or courses - just show history
        ),
      );
      return; // Don't call API when input is empty
    }

    // Hide history when user starts typing
    emit(
      state.copyWith(
        showHistory: false,
      ),
    );

    // Set up new debounce timer for API call
    _debounce = Timer(const Duration(milliseconds: 350), () {
      searchAll(
        searchQuery: query,
        filters: state.filters,
        ordering: '-price',
        page: 1,
        pageSize: 5,
      );
    });
  }

  //?-------------------------------------------------
  //* Search All (Courses, Articles, Teachers)
  Future<void> searchAll({
    String? searchQuery,
    CourseFiltersModel? filters,
    String? ordering,
    int page = 1,
    int pageSize = 5,
  }) async {
    if (searchQuery == null || searchQuery.trim().isEmpty) {
      emit(
        state.copyWith(
          status: ResponseStatusEnum.initial,
          courses: [],
          articles: [],
          teachers: [],
          searchQuery: null,
          hasSearched: false,
          error: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ResponseStatusEnum.loading,
        error: null,
        searchQuery: searchQuery.trim(),
        hasSearched: true,
        showHistory: false,
      ),
    );

    // Search all three types in parallel
    final results = await Future.wait([
      courseRepository.getCoursesRepo(
        search: searchQuery.trim(),
        filters: filters ?? state.filters,
        ordering: ordering ?? '-price',
        page: page,
        pageSize: pageSize,
      ),
      articleRepository.getArticlesRepo(
        search: searchQuery.trim(),
        page: page,
        pageSize: pageSize,
      ),
      teacherRepository.getTeachersRepo(
        search: searchQuery.trim(),
        page: page,
        pageSize: pageSize,
      ),
    ]);

    // Process results
    final courseResult = results[0];
    final articleResult = results[1];
    final teacherResult = results[2];

    courseResult.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search courses - ${failure.message}');
      },
      (coursesResult) {
        log('✅ SearchCubit: Loaded ${coursesResult.courses?.length ?? 0} courses');
      },
    );

    articleResult.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search articles - ${failure.message}');
      },
      (articleResponse) {
        log('✅ SearchCubit: Loaded ${articleResponse.results.length} articles');
      },
    );

    teacherResult.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search teachers - ${failure.message}');
      },
      (teacherResponse) {
        log('✅ SearchCubit: Loaded ${teacherResponse.results.length} teachers');
      },
    );

    // Extract results (handle failures gracefully - show partial results)
    final courses = courseResult.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search courses - ${failure.message}');
        return <CourseModel>[];
      },
      (result) => result.courses ?? [],
    );

    final articles = articleResult.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search articles - ${failure.message}');
        return <ArticleModel>[];
      },
      (result) => result.results,
    );

    final teachers = teacherResult.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search teachers - ${failure.message}');
        return <TeacherModel>[];
      },
      (result) => result.results,
    );

    // Check if all failed
    final allFailed = courseResult.isLeft() &&
        articleResult.isLeft() &&
        teacherResult.isLeft();
    if (allFailed) {
      final errorMessage = courseResult.fold(
        (failure) => failure.message,
        (_) => 'Unknown error',
      );
      emit(
        state.copyWith(
          status: ResponseStatusEnum.failure,
          error: errorMessage,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ResponseStatusEnum.success,
        courses: courses,
        articles: articles,
        teachers: teachers,
        error: null,
      ),
    );
  }

  //?-------------------------------------------------
  //* Search Courses
  Future<void> searchCourses({
    String? searchQuery,
    CourseFiltersModel? filters,
    String? ordering,
    int page = 1,
    int pageSize = 5,
  }) async {
    // If search query is empty or null, don't search
    if (searchQuery == null || searchQuery.trim().isEmpty) {
      emit(
        state.copyWith(
          status: ResponseStatusEnum.initial,
          courses: [],
          searchQuery: null,
          hasSearched: false,
          error: null,
        ),
      );
      return;
    }

    // Emit loading state
    emit(
      state.copyWith(
        status: ResponseStatusEnum.loading,
        error: null,
        searchQuery: searchQuery.trim(),
        hasSearched: true,
        showHistory: false, // Hide history when searching
      ),
    );

    log(
      'SearchCubit: Searching courses with query="$searchQuery", filters=$filters, ordering=$ordering, page=$page, pageSize=$pageSize',
    );

    final result = await courseRepository.getCoursesRepo(
      search: searchQuery.trim(),
      filters: filters ?? state.filters,
      ordering: ordering ?? '-price',
      page: page,
      pageSize: pageSize,
    );

    result.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search courses - ${failure.message}');
        emit(
          state.copyWith(
            status: ResponseStatusEnum.failure,
            error: failure.message,
            courses: [],
          ),
        );
      },
      (coursesResult) {
        log(
          '✅ SearchCubit: Successfully loaded ${coursesResult.courses?.length ?? 0} courses',
        );
        emit(
          state.copyWith(
            status: ResponseStatusEnum.success,
            courses: coursesResult.courses ?? [],
            error: null,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------
  //* Update Filters
  void updateFilters(CourseFiltersModel? filters) {
    emit(state.copyWith(filters: filters));
  }

  //?-------------------------------------------------
  //* Apply Filters by IDs
  void applyFiltersByIds({
    int? universityId,
    int? collegeId,
    int? categoryId,
    int? studyYear,
  }) {
    final filters = CourseFiltersModel(
      collegeId: collegeId,
      categoryId: categoryId,
      studyYear: studyYear,
    );

    updateFilters(filters);

    // If there's an active search query, re-search with new filters
    if (state.searchQuery != null && state.searchQuery!.trim().isNotEmpty) {
      searchCourses(
        searchQuery: state.searchQuery,
        filters: filters,
        ordering: '-price',
        page: 1,
        pageSize: 5,
      );
    }
  }

  //?-------------------------------------------------
  //* Clear Search
  void clearSearch() {
    // Cancel any pending debounce timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    emit(
      state.copyWith(
        status: ResponseStatusEnum.initial,
        courses: [],
        articles: [],
        teachers: [],
        searchQuery: null,
        hasSearched: false,
        error: null,
        showHistory: true, // Show history when search is cleared
      ),
    );
  }

  //?-------------------------------------------------
  //* Add to Search History
  void addToSearchHistory(String query) {
    if (query.trim().isEmpty) return;

    final trimmedQuery = query.trim();
    final currentHistory = List<String>.from(state.searchHistory);

    // Remove if already exists
    currentHistory.remove(trimmedQuery);

    // Add to beginning
    currentHistory.insert(0, trimmedQuery);

    // Keep only last 10
    if (currentHistory.length > 10) {
      currentHistory.removeRange(10, currentHistory.length);
    }

    emit(state.copyWith(searchHistory: currentHistory));
  }

  //?-------------------------------------------------
  //* Remove from Search History
  void removeFromSearchHistory(int index) {
    final currentHistory = List<String>.from(state.searchHistory);
    if (index >= 0 && index < currentHistory.length) {
      currentHistory.removeAt(index);
      emit(state.copyWith(searchHistory: currentHistory));
    }
  }

  //?-------------------------------------------------
  //* Set Query in Search Input (from history tap)
  void setQueryInInput(String query) {
    emit(state.copyWith(queryToSet: query));
    // Optional: clear immediately in next microtask
    Future.microtask(() => clearQueryToSet());
  }

  //?-------------------------------------------------
  //* Clear Query To Set (after it's been set in the input)
  void clearQueryToSet() {
    emit(
      state.copyWith(
        queryToSet: null,
      ),
    );
  }

  //?-------------------------------------------------
  //* Change Tab Index
  void changeTabIndex(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }
}
