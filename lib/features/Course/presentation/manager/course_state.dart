import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/courses_result/courses_result_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/enroll/channel_model.dart';
import 'package:e_learning/features/Course/data/models/enrollment_model.dart';
import 'package:e_learning/features/Course/data/models/paginated_enrollments_model.dart';
import 'package:e_learning/features/Course/data/models/rating_result/ratings_result_model.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/chapters_result/chapters_result_model.dart';
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
  final int? selectedCategoryId;

  //* Get Colleges
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
  final CoursesResultModel? courses;
  final ResponseStatusEnum coursesStatus;
  final String? coursesError;
  final String? coursesMoreError;
  final ResponseStatusEnum loadCoursesMoreStatus;

  //* Get Ratings
  final RatingsResultModel? ratings;
  final ResponseStatusEnum ratingsStatus;
  final String? ratingsError;
  final String? ratingsMoreError;
  final ResponseStatusEnum loadratingsMoreStatus;

  //* Get Chapters by  ID Course ( Chapters Tap )
  final ChaptersResultModel? chapters;
  final ResponseStatusEnum chaptersStatus;
  final String? chaptersError;
  final String? chaptersMoreError;
  final ResponseStatusEnum loadchaptersMoreStatus;

  //* Pagination
  final bool hasMoreCourses;
  final int currentPage;

  //* Get Course Details by Slug Course ( About Tab )
  final CourseDetailsModel? courseDetails;
  final ResponseStatusEnum courseDetailsStatus;
  final String? courseDetailsError;

  //* Toggle Is Favorite
  final String? isFavoriteError;

  //* Add Rating
  final ResponseStatusEnum addRatingStatus;
  final String? addRatingError;

  //* Enroll Cource
  final ResponseStatusEnum enrollStatus;
  final String? enrollError;

  //* Enroll Cource B
  final ResponseStatusEnum enrollStatusB;

  //* Get Channels
  final List<ChannelModel>? channels;
  final ResponseStatusEnum channelsStatus;
  final String? channelsError;

  //* Get My Courses (Enrollments)
  final PaginatedEnrollmentsModel? myCourses;
  final ResponseStatusEnum myCoursesStatus;
  final String? myCoursesError;

  //?----------------------------------------------------------------
  CourseState({
    //* Get Chapters by Course
    this.chapters,
    this.chaptersStatus = ResponseStatusEnum.initial,
    this.loadchaptersMoreStatus = ResponseStatusEnum.initial,
    this.chaptersError,
    this.chaptersMoreError,

    //* Get Courses
    this.courses,
    this.coursesStatus = ResponseStatusEnum.initial,
    this.loadCoursesMoreStatus = ResponseStatusEnum.initial,
    this.coursesError,
    this.coursesMoreError,

    //* Get Ratings
    this.ratings,
    this.ratingsStatus = ResponseStatusEnum.initial,
    this.loadratingsMoreStatus = ResponseStatusEnum.initial,
    this.ratingsError,
    this.ratingsMoreError,

    //* Get Course Details by ID
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
    this.selectedCategoryId,

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

    //* Add Rating
    this.addRatingStatus = ResponseStatusEnum.initial,
    this.addRatingError,

    //* Enroll Cource
    this.enrollStatus = ResponseStatusEnum.initial,
    this.enrollError,

    //* Enroll Cource B
    this.enrollStatusB = ResponseStatusEnum.initial,

    //* Get Channels
    this.channels,
    this.channelsStatus = ResponseStatusEnum.initial,
    this.channelsError,

    //* Get My Courses (Enrollments)
    this.myCourses,
    this.myCoursesStatus = ResponseStatusEnum.initial,
    this.myCoursesError,
  });

  //?------------------------------------------------------------------
  CourseState copyWith({
    //* Get Chapters by Course
    ChaptersResultModel? chapters,
    ResponseStatusEnum? chaptersStatus,
    String? chaptersError,
    String? chaptersMoreError,
    ResponseStatusEnum? loadchaptersMoreStatus,

    //* Get Courses
    CoursesResultModel? courses,
    ResponseStatusEnum? coursesStatus,
    ResponseStatusEnum? loadCoursesMoreStatus,
    String? coursesError,
    String? coursesMoreError,

    //* Get Ratings
    RatingsResultModel? ratings,
    ResponseStatusEnum? ratingsStatus,
    ResponseStatusEnum? loadratingsMoreStatus,
    String? ratingsError,
    String? ratingsMoreError,

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
    int? selectedCategoryId,

    //* Toggle Is Favorite
    String? isFavoriteError,

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

    //* Add Rating
    ResponseStatusEnum? addRatingStatus,
    String? addRatingError,

    //* Enroll Cource
    ResponseStatusEnum? enrollStatus,
    String? enrollError,

    //* Enroll Cource B
    ResponseStatusEnum? enrollStatusB,

    //* Get Channels
    List<ChannelModel>? channels,
    ResponseStatusEnum? channelsStatus,
    String? channelsError,

    //* Get My Courses (Enrollments)
    PaginatedEnrollmentsModel? myCourses,
    ResponseStatusEnum? myCoursesStatus,
    String? myCoursesError,
  }) {
    return CourseState(
      //* Get Chapters by Course
      chapters: chapters ?? this.chapters,
      chaptersStatus: chaptersStatus ?? this.chaptersStatus,
      loadchaptersMoreStatus:
          loadchaptersMoreStatus ?? this.loadchaptersMoreStatus,
      chaptersError: chaptersError,
      chaptersMoreError: chaptersMoreError,

      //* Get Ratings
      ratings: ratings ?? this.ratings,
      ratingsStatus: ratingsStatus ?? this.ratingsStatus,
      loadratingsMoreStatus:
          loadratingsMoreStatus ?? this.loadratingsMoreStatus,
      ratingsError: ratingsError,
      ratingsMoreError: ratingsMoreError,

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

      //* Add Rating
      addRatingStatus: addRatingStatus ?? this.addRatingStatus,
      addRatingError: addRatingError,

      //* Enroll Cource
      enrollStatus: enrollStatus ?? this.enrollStatus,
      enrollError: enrollError,

      //* Enroll Cource
      enrollStatusB: enrollStatusB ?? this.enrollStatusB,

      //* Get Channels
      channels: channels ?? this.channels,
      channelsStatus: channelsStatus ?? this.channelsStatus,
      channelsError: channelsError,

      //* Get My Courses (Enrollments)
      myCourses: myCourses ?? this.myCourses,
      myCoursesStatus: myCoursesStatus ?? this.myCoursesStatus,
      myCoursesError: myCoursesError,
    );
  }
}
