import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/study_year_model.dart';

class CourseState {
  //?---------------------------------------------------------------
  //* Toggle Between Tabs
  final int selectedIndex;

  //* Filter Category
  final List<CategorieModel>? categories;
  final ResponseStatusEnum categoriesStatus;
  final String? categoriesError;
  final int? selectedCategoryId;

  //* Filter Colleges
  final List<CollegeModel>? colleges;
  final ResponseStatusEnum collegesStatus;
  final String? collegesError;

  //* Filter Universities
  final List<UniversityModel>? universities;
  final ResponseStatusEnum universitiesState;
  final String? universitiesError;

  //* Filter Study Years
  final List<StudyYearModel>? studyYears;
  final ResponseStatusEnum studyYearsStatus;
  final String? studyYearsError;

  //* Course Filters
  final CourseFiltersModel? coursefilters;

  //* Get Courses
  final List<CourseModel>? courses;
  final ResponseStatusEnum coursesStatus;
  final String? coursesError;

  //* Get Course Details by Slug
  final CourseDetailsModel? courseDetails;
  final ResponseStatusEnum courseDetailsStatus;
  final String? courseDetailsError;

  //* Get Chapters by Course
  final List<ChapterModel>? chapters;
  final ResponseStatusEnum chaptersStatus;
  final String? chaptersError;

  //* Search
  final String? searchQuery;
  final List<String> searchHistory;
  final List<CourseModel>? searchResults;
  final ResponseStatusEnum searchStatus;
  final String? searchError;
  //?----------------------------------------------------------------
  CourseState({
    //* Get Chapters by Course
    this.chapters,
    this.chaptersStatus = ResponseStatusEnum.initial,
    this.chaptersError,

    //* Get Course Details by Slug
    this.courseDetails,
    this.courseDetailsStatus = ResponseStatusEnum.initial,
    this.courseDetailsError,

    //* Toggle Between Tabs
    this.selectedIndex = 0,

    //* Get Category
    this.categories,
    this.categoriesStatus = ResponseStatusEnum.initial,
    this.categoriesError,
    this.selectedCategoryId,

    //* Get Courses
    this.courses,
    this.coursesStatus = ResponseStatusEnum.initial,
    this.coursesError,

    //* Get Colleges
    this.colleges,
    this.collegesStatus = ResponseStatusEnum.initial,
    this.collegesError,

    //* Get Universities
    this.universities,
    this.universitiesState = ResponseStatusEnum.initial,
    this.universitiesError,

    //* Get Study Years
    this.studyYears,
    this.studyYearsStatus = ResponseStatusEnum.initial,
    this.studyYearsError,

    //* Course Filters
    this.coursefilters,

    //* Search
    this.searchQuery,
    this.searchHistory = const [],
    this.searchResults,
    this.searchStatus = ResponseStatusEnum.initial,
    this.searchError,
  });
  //?------------------------------------------------------------------

  CourseState copyWith({
    //* Get Chapters by Course
    List<ChapterModel>? chapters,
    ResponseStatusEnum? chaptersStatus,
    String? chaptersError,

    //* Get Course Details by Slug
    CourseDetailsModel? courseDetails,
    ResponseStatusEnum? courseDetailsStatus,
    String? courseDetailsError,

    //* Toggle Between Tabs
    int? selectedIndex,

    //* Get Category
    List<CategorieModel>? categories,
    ResponseStatusEnum? categoriesStatus,
    String? categoriesError,
    int? selectedCategoryId,

    //* Get Courses
    List<CourseModel>? courses,
    ResponseStatusEnum? coursesStatus,
    String? coursesError,

    //* Get Colleges
    List<CollegeModel>? colleges,
    ResponseStatusEnum? collegesStatus,
    String? collegesError,

    //* Get Universities
    List<UniversityModel>? universities,
    ResponseStatusEnum? universitiesState,
    String? universitiesError,

    //* Get Study Years
    List<StudyYearModel>? studyYears,
    ResponseStatusEnum? studyYearsStatus,
    String? studyYearsError,

    //* Course Filters
    CourseFiltersModel? coursefilters,

    //* Search
    String? searchQuery,
    List<String>? searchHistory,
    List<CourseModel>? searchResults,
    ResponseStatusEnum? searchStatus,
    String? searchError,
  }) {
    return CourseState(
      //* Get Chapters by Course
      chapters: chapters ?? this.chapters,
      chaptersStatus: chaptersStatus ?? this.chaptersStatus,
      chaptersError: chaptersError,

      //* Get Course Details by Slug
      courseDetails: courseDetails ?? this.courseDetails,
      courseDetailsStatus: courseDetailsStatus ?? this.courseDetailsStatus,
      courseDetailsError: courseDetailsError,

      //* Toggle Between Tabs
      selectedIndex: selectedIndex ?? this.selectedIndex,

      //* Get Category
      categories: categories ?? this.categories,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categoriesError: categoriesError ?? this.categoriesError,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,

      //* Get Courses
      courses: courses ?? this.courses,
      coursesStatus: coursesStatus ?? this.coursesStatus,
      coursesError: coursesError ?? this.coursesError,

      //* Get Colleges
      colleges: colleges ?? this.colleges,
      collegesStatus: collegesStatus ?? this.collegesStatus,
      collegesError: collegesError ?? this.collegesError,

      //* Get Universities
      universities: universities ?? this.universities,
      universitiesState: universitiesState ?? this.universitiesState,
      universitiesError: universitiesError ?? this.universitiesError,

      //* Get Study Years
      studyYears: studyYears ?? this.studyYears,
      studyYearsStatus: studyYearsStatus ?? this.studyYearsStatus,
      studyYearsError: studyYearsError ?? this.studyYearsError,

      //* Course Filters
      coursefilters: coursefilters ?? this.coursefilters,

      //* Search
      searchQuery: searchQuery ?? this.searchQuery,
      searchHistory: searchHistory ?? this.searchHistory,
      searchResults: searchResults ?? this.searchResults,
      searchStatus: searchStatus ?? this.searchStatus,
      searchError: searchError ?? this.searchError,
    );
  }

  //?-------------------------------------------------
}
