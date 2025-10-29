import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/course/data/models/course_details_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';

class CourseState {
  //?---------------------------------------------------------------
  //* Toggle Between Tabs
  final int selectedIndex;

  //* Filter Category
  final List<CategorieModel>? categories;
  final ResponseStatusEnum categoriesStatus;
  final String? categoriesError;

  //* Filter Colleges
  final List<CollegeModel>? colleges;
  final ResponseStatusEnum collegesStatus;
  final String? collegesError;

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

    //* Get Courses
    this.courses,
    this.coursesStatus = ResponseStatusEnum.initial,
    this.coursesError,

    //* Get Colleges
    this.colleges,
    this.collegesStatus = ResponseStatusEnum.initial,
    this.collegesError,
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

    //* Get Courses
    List<CourseModel>? courses,
    ResponseStatusEnum? coursesStatus,
    String? coursesError,

    //* Get Colleges
    List<CollegeModel>? colleges,
    ResponseStatusEnum? collegesStatus,
    String? collegesError,
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

      //* Get Courses
      courses: courses ?? this.courses,
      coursesStatus: coursesStatus ?? this.coursesStatus,
      coursesError: coursesError ?? this.coursesError,

      //* Get Colleges
      colleges: colleges ?? this.colleges,
      collegesStatus: collegesStatus ?? this.collegesStatus,
      collegesError: collegesError ?? this.collegesError,
    );
  }

  //?-------------------------------------------------
}
