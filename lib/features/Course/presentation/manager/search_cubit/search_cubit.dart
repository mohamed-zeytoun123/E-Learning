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
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/courses_result/courses_result_model.dart';
import 'package:e_learning/features/Article/data/models/article_response_model.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_response_model.dart';
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
        pageSize: 20,
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
    final courseResult = await courseRepository.getCoursesRepo(
      search: searchQuery.trim(),
      filters: filters ?? state.filters,
      ordering: ordering ?? '-price',
      page: page,
      pageSize: pageSize,
    );
    
    final articleResult = await articleRepository.getArticlesRepo(
      search: searchQuery.trim(),
      page: page,
      pageSize: pageSize,
    );
    
    // Use the new search endpoint for teachers
    final teacherResult = await teacherRepository.searchTeachersRepo(
      query: searchQuery.trim(),
      limit: pageSize,
      offset: 0, // Start from beginning for initial search
    );

    courseResult.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search courses - ${failure.message}');
      },
      (CoursesResultModel coursesResult) {
        log('✅ SearchCubit: Loaded ${coursesResult.courses?.length ?? 0} courses');
      },
    );

    articleResult.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search articles - ${failure.message}');
      },
      (ArticleResponseModel articleResponse) {
        log('✅ SearchCubit: Loaded ${articleResponse.results.length} articles');
      },
    );

    teacherResult.fold(
      (failure) {
        log('❌ SearchCubit: Failed to search teachers - ${failure.message}');
      },
      (TeacherResponseModel teacherResponse) {
        log('✅ SearchCubit: Loaded ${teacherResponse.results.length} teachers');
      },
    );

    // Extract results (handle failures gracefully - show partial results)
    final courses = courseResult.fold<List<CourseModel>>(
      (failure) {
        log('❌ SearchCubit: Failed to search courses - ${failure.message}');
        return <CourseModel>[];
      },
      (CoursesResultModel result) => result.courses ?? [],
    );

    final articles = articleResult.fold<List<ArticleModel>>(
      (failure) {
        log('❌ SearchCubit: Failed to search articles - ${failure.message}');
        return <ArticleModel>[];
      },
      (ArticleResponseModel result) => result.results,
    );

    final teachers = teacherResult.fold<List<TeacherModel>>(
      (failure) {
        log('❌ SearchCubit: Failed to search teachers - ${failure.message}');
        return <TeacherModel>[];
      },
      (TeacherResponseModel result) => result.results,
    );

    // Check if all failed
    bool allFailed = false;
    courseResult.fold(
      (_) {
        articleResult.fold(
          (_) {
            teacherResult.fold(
              (_) => allFailed = true,
              (_) {},
            );
          },
          (_) {},
        );
      },
      (_) {},
    );
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

    // Extract pagination info
    final coursesPagination = courseResult.fold(
      (_) => (currentPage: 1, totalPages: 1, hasNext: false),
      (result) => (
        currentPage: page,
        totalPages: 1, // CoursesResultModel doesn't have totalPages
        hasNext: result.hasNextPage,
      ),
    );

    final articlesPagination = articleResult.fold(
      (_) => (currentPage: 1, totalPages: 1, hasNext: false),
      (result) => (
        currentPage: result.currentPage,
        totalPages: result.totalPages,
        hasNext: result.next != null,
      ),
    );

    final teachersPagination = teacherResult.fold(
      (_) => (currentPage: 1, totalPages: 1, hasNext: false, offset: 0),
      (result) => (
        currentPage: result.currentPage,
        totalPages: result.totalPages,
        hasNext: result.next != null,
        offset: teachers.length, // Next offset is current count
      ),
    );

    emit(
      state.copyWith(
        status: ResponseStatusEnum.success,
        courses: courses,
        articles: articles,
        teachers: teachers,
        error: null,
        coursesCurrentPage: coursesPagination.currentPage,
        coursesTotalPages: coursesPagination.totalPages,
        coursesHasNextPage: coursesPagination.hasNext,
        articlesCurrentPage: articlesPagination.currentPage,
        articlesTotalPages: articlesPagination.totalPages,
        articlesHasNextPage: articlesPagination.hasNext,
        teachersCurrentPage: teachersPagination.currentPage,
        teachersTotalPages: teachersPagination.totalPages,
        teachersHasNextPage: teachersPagination.hasNext,
        teachersOffset: teachersPagination.offset,
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

  //?-------------------------------------------------
  //* Load More Courses
  Future<void> loadMoreCourses() async {
    if (!state.coursesHasNextPage ||
        state.status == ResponseStatusEnum.loading ||
        state.searchQuery == null ||
        state.searchQuery!.trim().isEmpty) {
      return;
    }

    final nextPage = state.coursesCurrentPage + 1;
    final result = await courseRepository.getCoursesRepo(
      search: state.searchQuery!.trim(),
      filters: state.filters,
      ordering: '-price',
      page: nextPage,
      pageSize: 20,
    );

    result.fold(
      (failure) {
        log('❌ SearchCubit: Failed to load more courses - ${failure.message}');
      },
      (coursesResult) {
        final newCourses = coursesResult.courses ?? [];
        final allCourses = [...state.courses, ...newCourses];
        emit(
          state.copyWith(
            courses: allCourses,
            coursesCurrentPage: nextPage,
            coursesHasNextPage: coursesResult.hasNextPage,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------
  //* Load More Articles
  Future<void> loadMoreArticles() async {
    if (!state.articlesHasNextPage ||
        state.status == ResponseStatusEnum.loading ||
        state.searchQuery == null ||
        state.searchQuery!.trim().isEmpty) {
      return;
    }

    final nextPage = state.articlesCurrentPage + 1;
    final result = await articleRepository.getArticlesRepo(
      search: state.searchQuery!.trim(),
      page: nextPage,
      pageSize: 20,
    );

    result.fold(
      (failure) {
        log('❌ SearchCubit: Failed to load more articles - ${failure.message}');
      },
      (articleResponse) {
        final allArticles = [...state.articles, ...articleResponse.results];
        emit(
          state.copyWith(
            articles: allArticles,
            articlesCurrentPage: articleResponse.currentPage,
            articlesTotalPages: articleResponse.totalPages,
            articlesHasNextPage: articleResponse.next != null,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------
  //* Load More Teachers
  Future<void> loadMoreTeachers() async {
    if (!state.teachersHasNextPage ||
        state.status == ResponseStatusEnum.loading ||
        state.searchQuery == null ||
        state.searchQuery!.trim().isEmpty) {
      return;
    }

    final result = await teacherRepository.searchTeachersRepo(
      query: state.searchQuery!.trim(),
      limit: 20,
      offset: state.teachersOffset,
    );

    result.fold(
      (failure) {
        log('❌ SearchCubit: Failed to load more teachers - ${failure.message}');
      },
      (teacherResponse) {
        final allTeachers = [...state.teachers, ...teacherResponse.results];
        emit(
          state.copyWith(
            teachers: allTeachers,
            teachersCurrentPage: teacherResponse.currentPage,
            teachersTotalPages: teacherResponse.totalPages,
            teachersHasNextPage: teacherResponse.next != null,
            teachersOffset: allTeachers.length, // Update offset for next load
          ),
        );
      },
    );
  }
}
