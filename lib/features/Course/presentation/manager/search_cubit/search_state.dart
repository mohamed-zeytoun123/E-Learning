import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';

class SearchState {
  final String? error;
  final ResponseStatusEnum status;
  final List<String> searchHistory;
  final String? universityFilter;
  final List<String> colleageFilter;
  final List<String> studyYearsFilter;
  final List<CourseModel> courses;
  final CourseFiltersModel? filters;
  final String? searchQuery;
  final bool hasSearched;
  final bool showHistory; // Show search history when input is empty
  final String? queryToSet; // Query to set in the search input (from history tap)

  SearchState({
    this.error,
    this.status = ResponseStatusEnum.initial,
    this.searchHistory = const [],
    this.courses = const [],
    this.universityFilter,
    this.colleageFilter = const [],
    this.studyYearsFilter = const [],
    this.filters,
    this.searchQuery,
    this.hasSearched = false,
    this.showHistory = true, // Default to showing history
    this.queryToSet,
  });

  SearchState copyWith({
    String? error,
    ResponseStatusEnum? status,
    List<String>? searchHistory,
    List<CourseModel>? courses,
    String? universityFilter,
    List<String>? colleageFilter,
    List<String>? studyYearsFilter,
    CourseFiltersModel? filters,
    String? searchQuery,
    bool? hasSearched,
    bool? showHistory,
    String? queryToSet,
  }) {
    return SearchState(
      error: error ?? this.error,
      status: status ?? this.status,
      searchHistory: searchHistory ?? this.searchHistory,
      courses: courses ?? this.courses,
      universityFilter: universityFilter ?? this.universityFilter,
      colleageFilter: colleageFilter ?? this.colleageFilter,
      studyYearsFilter: studyYearsFilter ?? this.studyYearsFilter,
      filters: filters ?? this.filters,
      searchQuery: searchQuery ?? this.searchQuery,
      hasSearched: hasSearched ?? this.hasSearched,
      showHistory: showHistory ?? this.showHistory,
      queryToSet: queryToSet ?? this.queryToSet,
    );
  }
}
