import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/courses_result/courses_result_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/chapter_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';

class CourseState {
  //?---------------------------------------------------------------
  //* Toggle Between Tabs
  final int selectedIndex;

  //* Get Category
  final List<CategorieModel>? categories;
  final ResponseStatusEnum categoriesStatus;
  final String? categoriesError;

  //* Get Colleges
  final List<CollegeModel>? colleges;
  final ResponseStatusEnum collegesStatus;
  final String? collegesError;

  //* Get Courses
  final CoursesResultModel? courses;
  final ResponseStatusEnum coursesStatus;
  final String? coursesError;
  final String? coursesMoreError;
  final ResponseStatusEnum loadCoursesMoreStatus;

  //* Pagination
  final bool hasMoreCourses;
  final int currentPage;

  //* Get Course Details by Slug Course ( About Tab )
  final CourseDetailsModel? courseDetails;
  final ResponseStatusEnum courseDetailsStatus;
  final String? courseDetailsError;

  //* Get Chapters by  Slug Course ( Chapters Tap )
  final List<ChapterModel>? chapters;
  final ResponseStatusEnum chaptersStatus;
  final String? chaptersError;

  //* Get Universities
  final List<UniversityModel>? universities;
  final ResponseStatusEnum universitiesState;
  final String? universitiesError;

  //* Get Study Years
  final List<StudyYearModel>? studyYears;
  final ResponseStatusEnum studyYearsStatus;
  final String? studyYearsError;

  //* Course Filters
  final CourseFiltersModel? coursefilters;

  //* Toggle Is Favorite
  final String? isFavoriteError;

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

    //* Course Filters
    this.coursefilters,

    //* Get Study Years
    this.studyYears,
    this.studyYearsStatus = ResponseStatusEnum.initial,
    this.studyYearsError,

    //* Get Category
    this.categories,
    this.categoriesStatus = ResponseStatusEnum.initial,
    this.categoriesError,

    //* Get Courses
    this.courses,
    this.coursesStatus = ResponseStatusEnum.initial,
    this.loadCoursesMoreStatus = ResponseStatusEnum.initial,
    this.coursesError,
    this.coursesMoreError,

    //* Pagination
    this.hasMoreCourses = true,
    // this.loadMoreStatus = ResponseStatusEnum.initial,
    this.currentPage = 1,

    //* Get Colleges
    this.colleges,
    this.collegesStatus = ResponseStatusEnum.initial,
    this.collegesError,

    //* Get Universities
    this.universities,
    this.universitiesState = ResponseStatusEnum.initial,
    this.universitiesError,

    //* Toggle Is Favorite
    this.isFavoriteError,
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

    //* Course Filters
    CourseFiltersModel? coursefilters,

    //* Get Study Years
    List<StudyYearModel>? studyYears,
    ResponseStatusEnum? studyYearsStatus,
    String? studyYearsError,

    //* Get Category
    List<CategorieModel>? categories,
    ResponseStatusEnum? categoriesStatus,
    String? categoriesError,

    //* Toggle Is Favorite
    String? isFavoriteError,

    //* Get Courses
    CoursesResultModel? courses,
    ResponseStatusEnum? coursesStatus,
    ResponseStatusEnum? loadCoursesMoreStatus,
    String? coursesError,
    String? coursesMoreError,

    //* Pagination
    bool? hasMoreCourses,
    // ResponseStatusEnum? loadMoreStatus,
    int? currentPage,

    //* Get Colleges
    List<CollegeModel>? colleges,
    ResponseStatusEnum? collegesStatus,
    String? collegesError,

    //* Get Universities
    List<UniversityModel>? universities,
    ResponseStatusEnum? universitiesState,
    String? universitiesError,
  }) {
    return CourseState(
      //* Get Chapters by Course
      chapters: chapters ?? this.chapters,
      chaptersStatus: chaptersStatus ?? this.chaptersStatus,
      chaptersError: chaptersError,

      //* Get Study Years
      studyYears: studyYears ?? this.studyYears,
      studyYearsStatus: studyYearsStatus ?? this.studyYearsStatus,
      studyYearsError: studyYearsError,

      //* Get Course Details by Slug
      courseDetails: courseDetails ?? this.courseDetails,
      courseDetailsStatus: courseDetailsStatus ?? this.courseDetailsStatus,
      courseDetailsError: courseDetailsError,

      //* Toggle Between Tabs
      selectedIndex: selectedIndex ?? this.selectedIndex,

      //* Course Filters
      coursefilters: coursefilters ?? this.coursefilters,

      //* Get Category
      categories: categories ?? this.categories,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categoriesError: categoriesError,

      //* Get Courses
      courses: courses ?? this.courses,
      coursesStatus: coursesStatus ?? this.coursesStatus,
      loadCoursesMoreStatus:
          loadCoursesMoreStatus ?? this.loadCoursesMoreStatus,
      coursesError: coursesError,
      coursesMoreError: coursesMoreError,

      //* Pagination
      hasMoreCourses: hasMoreCourses ?? this.hasMoreCourses,
      // loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
      currentPage: currentPage ?? this.currentPage,

      //* Get Colleges
      colleges: colleges ?? this.colleges,
      collegesStatus: collegesStatus ?? this.collegesStatus,
      collegesError: collegesError,

      //* Get Universities
      universities: universities ?? this.universities,
      universitiesState: universitiesState ?? this.universitiesState,
      universitiesError: universitiesError,

      //* Toggle Is Favorite
      isFavoriteError: isFavoriteError,
    );
  }
}
