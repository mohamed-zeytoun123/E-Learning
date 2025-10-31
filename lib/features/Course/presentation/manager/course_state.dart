import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/course/data/models/course_details_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';

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
  final List<CourseModel>? courses;
  final ResponseStatusEnum coursesStatus;
  final String? coursesError;

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

  //* Course Filters
  final CourseFiltersModel? coursefilters;

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

    //* Get Category
    this.categories,
    this.categoriesStatus = ResponseStatusEnum.initial,
    this.categoriesError,

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

    //* Get Category
    List<CategorieModel>? categories,
    ResponseStatusEnum? categoriesStatus,
    String? categoriesError,

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

      //* Course Filters
      coursefilters: coursefilters ?? this.coursefilters,

      //* Get Category
      categories: categories ?? this.categories,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categoriesError: categoriesError ?? this.categoriesError,

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
      universitiesError: universitiesError,
    );
  }

  //?-------------------------------------------------
}
