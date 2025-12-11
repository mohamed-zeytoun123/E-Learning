import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Article/data/models/article_model/article_model.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';

class SearchState {
  final String? error;
  final ResponseStatusEnum status;
  final List<String> searchHistory;
  final String? universityFilter;
  final List<String> colleageFilter;
  final List<String> studyYearsFilter;
  final List<CourseModel> courses;
  final List<ArticleModel> articles;
  final List<TeacherModel> teachers;
  final CourseFiltersModel? filters;
  final String? searchQuery;
  final bool hasSearched;
  final bool showHistory; // Show search history when input is empty
  final String?
      queryToSet; // Query to set in the search input (from history tap)
  final int selectedTabIndex; // 0: Courses, 1: Articles, 2: Teachers

  // Pagination info
  final int coursesCurrentPage;
  final int coursesTotalPages;
  final bool coursesHasNextPage;
  final int articlesCurrentPage;
  final int articlesTotalPages;
  final bool articlesHasNextPage;
  final int teachersCurrentPage;
  final int teachersTotalPages;
  final bool teachersHasNextPage;
  final int teachersOffset; // For teachers search API

  SearchState({
    this.error,
    this.status = ResponseStatusEnum.initial,
    this.searchHistory = const [],
    this.courses = const [],
    this.articles = const [],
    this.teachers = const [],
    this.universityFilter,
    this.colleageFilter = const [],
    this.studyYearsFilter = const [],
    this.filters,
    this.searchQuery,
    this.hasSearched = false,
    this.showHistory = true, // Default to showing history
    this.queryToSet,
    this.selectedTabIndex = 0, // Default to Courses tab
    this.coursesCurrentPage = 1,
    this.coursesTotalPages = 1,
    this.coursesHasNextPage = false,
    this.articlesCurrentPage = 1,
    this.articlesTotalPages = 1,
    this.articlesHasNextPage = false,
    this.teachersCurrentPage = 1,
    this.teachersTotalPages = 1,
    this.teachersHasNextPage = false,
    this.teachersOffset = 0,
  });

  SearchState copyWith({
    String? error,
    ResponseStatusEnum? status,
    List<String>? searchHistory,
    List<CourseModel>? courses,
    List<ArticleModel>? articles,
    List<TeacherModel>? teachers,
    String? universityFilter,
    List<String>? colleageFilter,
    List<String>? studyYearsFilter,
    CourseFiltersModel? filters,
    String? searchQuery,
    bool? hasSearched,
    bool? showHistory,
    String? queryToSet,
    int? selectedTabIndex,
    int? coursesCurrentPage,
    int? coursesTotalPages,
    bool? coursesHasNextPage,
    int? articlesCurrentPage,
    int? articlesTotalPages,
    bool? articlesHasNextPage,
    int? teachersCurrentPage,
    int? teachersTotalPages,
    bool? teachersHasNextPage,
    int? teachersOffset,
  }) {
    return SearchState(
      error: error ?? this.error,
      status: status ?? this.status,
      searchHistory: searchHistory ?? this.searchHistory,
      courses: courses ?? this.courses,
      articles: articles ?? this.articles,
      teachers: teachers ?? this.teachers,
      universityFilter: universityFilter ?? this.universityFilter,
      colleageFilter: colleageFilter ?? this.colleageFilter,
      studyYearsFilter: studyYearsFilter ?? this.studyYearsFilter,
      filters: filters ?? this.filters,
      searchQuery: searchQuery ?? this.searchQuery,
      hasSearched: hasSearched ?? this.hasSearched,
      showHistory: showHistory ?? this.showHistory,
      queryToSet: queryToSet ?? this.queryToSet,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      coursesCurrentPage: coursesCurrentPage ?? this.coursesCurrentPage,
      coursesTotalPages: coursesTotalPages ?? this.coursesTotalPages,
      coursesHasNextPage: coursesHasNextPage ?? this.coursesHasNextPage,
      articlesCurrentPage: articlesCurrentPage ?? this.articlesCurrentPage,
      articlesTotalPages: articlesTotalPages ?? this.articlesTotalPages,
      articlesHasNextPage: articlesHasNextPage ?? this.articlesHasNextPage,
      teachersCurrentPage: teachersCurrentPage ?? this.teachersCurrentPage,
      teachersTotalPages: teachersTotalPages ?? this.teachersTotalPages,
      teachersHasNextPage: teachersHasNextPage ?? this.teachersHasNextPage,
      teachersOffset: teachersOffset ?? this.teachersOffset,
    );
  }
}
