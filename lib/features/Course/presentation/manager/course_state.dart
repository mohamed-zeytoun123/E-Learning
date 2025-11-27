// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:flutter/foundation.dart';

import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/courses_result/courses_result_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/enroll/channel_model.dart';
import 'package:e_learning/features/Course/data/models/rating_result/ratings_result_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
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

  //?----------------------------------------------------------------
  CourseState({
    //* Get Chapters by Course
    //* Get Courses
    //* Get Ratings
    //* Get Course Details by ID
    //* Toggle Between Tabs
    //* Course Filters
    //* Get Study Years
    //* Get Category
    //* Pagination
    // this.loadMoreStatus = ResponseStatusEnum.initial,
    //* Get Colleges
    //* Get Universities
    //* Toggle Is Favorite
    //* Add Rating
    //* Enroll Cource
    //* Enroll Cource B
    //* Get Channels
    this.selectedIndex = 0,
    this.categories,
    this.categoriesStatus = ResponseStatusEnum.initial,
    this.categoriesError,
    this.colleges,
    this.collegesStatus = ResponseStatusEnum.initial,
    this.collegesError,
    this.courses,
    this.coursesStatus = ResponseStatusEnum.initial,
    this.coursesError,
    this.coursesMoreError,
    this.loadCoursesMoreStatus = ResponseStatusEnum.initial,
    this.ratings,
    this.ratingsStatus = ResponseStatusEnum.initial,
    this.ratingsError,
    this.ratingsMoreError,
    this.loadratingsMoreStatus = ResponseStatusEnum.initial,
    this.chapters,
    this.chaptersStatus = ResponseStatusEnum.initial,
    this.chaptersError,
    this.chaptersMoreError,
    this.loadchaptersMoreStatus = ResponseStatusEnum.initial,
    this.hasMoreCourses = true,
    this.currentPage = 1,
    this.courseDetails,
    this.courseDetailsStatus = ResponseStatusEnum.initial,
    this.courseDetailsError,
    this.universities,
    this.universitiesState = ResponseStatusEnum.initial,
    this.universitiesError,
    this.studyYears,
    this.studyYearsStatus = ResponseStatusEnum.initial,
    this.studyYearsError,
    this.coursefilters,
    this.isFavoriteError,
    this.addRatingStatus = ResponseStatusEnum.initial,
    this.addRatingError,
    this.enrollStatus = ResponseStatusEnum.initial,
    this.enrollError,
    this.enrollStatusB = ResponseStatusEnum.initial,
    this.channels,
    this.channelsStatus = ResponseStatusEnum.initial,
    this.channelsError,
  });

  //?------------------------------------------------------------------
  CourseState copyWith({
    int? selectedIndex,
    List<CategorieModel>? categories,
    ResponseStatusEnum? categoriesStatus,
    String? categoriesError,
    List<CollegeModel>? colleges,
    ResponseStatusEnum? collegesStatus,
    String? collegesError,
    CoursesResultModel? courses,
    ResponseStatusEnum? coursesStatus,
    String? coursesError,
    String? coursesMoreError,
    ResponseStatusEnum? loadCoursesMoreStatus,
    RatingsResultModel? ratings,
    ResponseStatusEnum? ratingsStatus,
    String? ratingsError,
    String? ratingsMoreError,
    ResponseStatusEnum? loadratingsMoreStatus,
    ChaptersResultModel? chapters,
    ResponseStatusEnum? chaptersStatus,
    String? chaptersError,
    String? chaptersMoreError,
    ResponseStatusEnum? loadchaptersMoreStatus,
    bool? hasMoreCourses,
    int? currentPage,
    CourseDetailsModel? courseDetails,
    ResponseStatusEnum? courseDetailsStatus,
    String? courseDetailsError,
    List<UniversityModel>? universities,
    ResponseStatusEnum? universitiesState,
    String? universitiesError,
    List<StudyYearModel>? studyYears,
    ResponseStatusEnum? studyYearsStatus,
    String? studyYearsError,
    CourseFiltersModel? coursefilters,
    String? isFavoriteError,
    ResponseStatusEnum? addRatingStatus,
    String? addRatingError,
    ResponseStatusEnum? enrollStatus,
    String? enrollError,
    ResponseStatusEnum? enrollStatusB,
    List<ChannelModel>? channels,
    ResponseStatusEnum? channelsStatus,
    String? channelsError,
  }) {
    return CourseState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      categories: categories ?? this.categories,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categoriesError: categoriesError ?? this.categoriesError,
      colleges: colleges ?? this.colleges,
      collegesStatus: collegesStatus ?? this.collegesStatus,
      collegesError: collegesError ?? this.collegesError,
      courses: courses ?? this.courses,
      coursesStatus: coursesStatus ?? this.coursesStatus,
      coursesError: coursesError ?? this.coursesError,
      coursesMoreError: coursesMoreError ?? this.coursesMoreError,
      loadCoursesMoreStatus: loadCoursesMoreStatus ?? this.loadCoursesMoreStatus,
      ratings: ratings ?? this.ratings,
      ratingsStatus: ratingsStatus ?? this.ratingsStatus,
      ratingsError: ratingsError ?? this.ratingsError,
      ratingsMoreError: ratingsMoreError ?? this.ratingsMoreError,
      loadratingsMoreStatus: loadratingsMoreStatus ?? this.loadratingsMoreStatus,
      chapters: chapters ?? this.chapters,
      chaptersStatus: chaptersStatus ?? this.chaptersStatus,
      chaptersError: chaptersError ?? this.chaptersError,
      chaptersMoreError: chaptersMoreError ?? this.chaptersMoreError,
      loadchaptersMoreStatus: loadchaptersMoreStatus ?? this.loadchaptersMoreStatus,
      hasMoreCourses: hasMoreCourses ?? this.hasMoreCourses,
      currentPage: currentPage ?? this.currentPage,
      courseDetails: courseDetails ?? this.courseDetails,
      courseDetailsStatus: courseDetailsStatus ?? this.courseDetailsStatus,
      courseDetailsError: courseDetailsError ?? this.courseDetailsError,
      universities: universities ?? this.universities,
      universitiesState: universitiesState ?? this.universitiesState,
      universitiesError: universitiesError ?? this.universitiesError,
      studyYears: studyYears ?? this.studyYears,
      studyYearsStatus: studyYearsStatus ?? this.studyYearsStatus,
      studyYearsError: studyYearsError ?? this.studyYearsError,
      coursefilters: coursefilters ?? this.coursefilters,
      isFavoriteError: isFavoriteError ?? this.isFavoriteError,
      addRatingStatus: addRatingStatus ?? this.addRatingStatus,
      addRatingError: addRatingError ?? this.addRatingError,
      enrollStatus: enrollStatus ?? this.enrollStatus,
      enrollError: enrollError ?? this.enrollError,
      enrollStatusB: enrollStatusB ?? this.enrollStatusB,
      channels: channels ?? this.channels,
      channelsStatus: channelsStatus ?? this.channelsStatus,
      channelsError: channelsError ?? this.channelsError,
    );
  }

  // Serialization not needed for Cubit state - commented out to fix errors
  /*factory CourseState.fromMap(Map<String, dynamic> map) {
    return CourseState(
      selectedIndex: map['selectedIndex'] as int,
      categories: map['categories'] != null ? List<CategorieModel>.from((map['categories'] as List<int>).map<CategorieModel?>((x) => CategorieModel.fromMap(x as Map<String,dynamic>),),) : null,
      categoriesStatus: ResponseStatusEnum.fromMap(map['categoriesStatus'] as Map<String,dynamic>),
      categoriesError: map['categoriesError'] != null ? map['categoriesError'] as String : null,
      colleges: map['colleges'] != null ? List<CollegeModel>.from((map['colleges'] as List<int>).map<CollegeModel?>((x) => CollegeModel.fromMap(x as Map<String,dynamic>),),) : null,
      collegesStatus: ResponseStatusEnum.fromMap(map['collegesStatus'] as Map<String,dynamic>),
      collegesError: map['collegesError'] != null ? map['collegesError'] as String : null,
      courses: map['courses'] != null ? CoursesResultModel.fromMap(map['courses'] as Map<String,dynamic>) : null,
      coursesStatus: ResponseStatusEnum.fromMap(map['coursesStatus'] as Map<String,dynamic>),
      coursesError: map['coursesError'] != null ? map['coursesError'] as String : null,
      coursesMoreError: map['coursesMoreError'] != null ? map['coursesMoreError'] as String : null,
      loadCoursesMoreStatus: ResponseStatusEnum.fromMap(map['loadCoursesMoreStatus'] as Map<String,dynamic>),
      ratings: map['ratings'] != null ? RatingsResultModel.fromMap(map['ratings'] as Map<String,dynamic>) : null,
      ratingsStatus: ResponseStatusEnum.fromMap(map['ratingsStatus'] as Map<String,dynamic>),
      ratingsError: map['ratingsError'] != null ? map['ratingsError'] as String : null,
      ratingsMoreError: map['ratingsMoreError'] != null ? map['ratingsMoreError'] as String : null,
      loadratingsMoreStatus: ResponseStatusEnum.fromMap(map['loadratingsMoreStatus'] as Map<String,dynamic>),
      chapters: map['chapters'] != null ? ChaptersResultModel.fromMap(map['chapters'] as Map<String,dynamic>) : null,
      chaptersStatus: ResponseStatusEnum.fromMap(map['chaptersStatus'] as Map<String,dynamic>),
      chaptersError: map['chaptersError'] != null ? map['chaptersError'] as String : null,
      chaptersMoreError: map['chaptersMoreError'] != null ? map['chaptersMoreError'] as String : null,
      loadchaptersMoreStatus: ResponseStatusEnum.fromMap(map['loadchaptersMoreStatus'] as Map<String,dynamic>),
      hasMoreCourses: map['hasMoreCourses'] as bool,
      currentPage: map['currentPage'] as int,
      courseDetails: map['courseDetails'] != null ? CourseDetailsModel.fromMap(map['courseDetails'] as Map<String,dynamic>) : null,
      courseDetailsStatus: ResponseStatusEnum.fromMap(map['courseDetailsStatus'] as Map<String,dynamic>),
      courseDetailsError: map['courseDetailsError'] != null ? map['courseDetailsError'] as String : null,
      universities: map['universities'] != null ? List<UniversityModel>.from((map['universities'] as List<int>).map<UniversityModel?>((x) => UniversityModel.fromMap(x as Map<String,dynamic>),),) : null,
      universitiesState: ResponseStatusEnum.fromMap(map['universitiesState'] as Map<String,dynamic>),
      universitiesError: map['universitiesError'] != null ? map['universitiesError'] as String : null,
      studyYears: map['studyYears'] != null ? List<StudyYearModel>.from((map['studyYears'] as List<int>).map<StudyYearModel?>((x) => StudyYearModel.fromMap(x as Map<String,dynamic>),),) : null,
      studyYearsStatus: ResponseStatusEnum.fromMap(map['studyYearsStatus'] as Map<String,dynamic>),
      studyYearsError: map['studyYearsError'] != null ? map['studyYearsError'] as String : null,
      coursefilters: map['coursefilters'] != null ? CourseFiltersModel.fromMap(map['coursefilters'] as Map<String,dynamic>) : null,
      isFavoriteError: map['isFavoriteError'] != null ? map['isFavoriteError'] as String : null,
      addRatingStatus: ResponseStatusEnum.fromMap(map['addRatingStatus'] as Map<String,dynamic>),
      addRatingError: map['addRatingError'] != null ? map['addRatingError'] as String : null,
      enrollStatus: ResponseStatusEnum.fromMap(map['enrollStatus'] as Map<String,dynamic>),
      enrollError: map['enrollError'] != null ? map['enrollError'] as String : null,
      enrollStatusB: ResponseStatusEnum.fromMap(map['enrollStatusB'] as Map<String,dynamic>),
      channels: map['channels'] != null ? List<ChannelModel>.from((map['channels'] as List<int>).map<ChannelModel?>((x) => ChannelModel.fromMap(x as Map<String,dynamic>),),) : null,
      channelsStatus: ResponseStatusEnum.fromMap(map['channelsStatus'] as Map<String,dynamic>),
      channelsError: map['channelsError'] != null ? map['channelsError'] as String : null,
    );
  } */

  // Serialization not needed for Cubit state
  // String toJson() => json.encode(toMap());

  // factory CourseState.fromJson(String source) => CourseState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseState(selectedIndex: $selectedIndex, categories: $categories, categoriesStatus: $categoriesStatus, categoriesError: $categoriesError, colleges: $colleges, collegesStatus: $collegesStatus, collegesError: $collegesError, courses: $courses, coursesStatus: $coursesStatus, coursesError: $coursesError, coursesMoreError: $coursesMoreError, loadCoursesMoreStatus: $loadCoursesMoreStatus, ratings: $ratings, ratingsStatus: $ratingsStatus, ratingsError: $ratingsError, ratingsMoreError: $ratingsMoreError, loadratingsMoreStatus: $loadratingsMoreStatus, chapters: $chapters, chaptersStatus: $chaptersStatus, chaptersError: $chaptersError, chaptersMoreError: $chaptersMoreError, loadchaptersMoreStatus: $loadchaptersMoreStatus, hasMoreCourses: $hasMoreCourses, currentPage: $currentPage, courseDetails: $courseDetails, courseDetailsStatus: $courseDetailsStatus, courseDetailsError: $courseDetailsError, universities: $universities, universitiesState: $universitiesState, universitiesError: $universitiesError, studyYears: $studyYears, studyYearsStatus: $studyYearsStatus, studyYearsError: $studyYearsError, coursefilters: $coursefilters, isFavoriteError: $isFavoriteError, addRatingStatus: $addRatingStatus, addRatingError: $addRatingError, enrollStatus: $enrollStatus, enrollError: $enrollError, enrollStatusB: $enrollStatusB, channels: $channels, channelsStatus: $channelsStatus, channelsError: $channelsError)';
  }

  @override
  bool operator ==(covariant CourseState other) {
    if (identical(this, other)) return true;
  
    return 
      other.selectedIndex == selectedIndex &&
      listEquals(other.categories, categories) &&
      other.categoriesStatus == categoriesStatus &&
      other.categoriesError == categoriesError &&
      listEquals(other.colleges, colleges) &&
      other.collegesStatus == collegesStatus &&
      other.collegesError == collegesError &&
      other.courses == courses &&
      other.coursesStatus == coursesStatus &&
      other.coursesError == coursesError &&
      other.coursesMoreError == coursesMoreError &&
      other.loadCoursesMoreStatus == loadCoursesMoreStatus &&
      other.ratings == ratings &&
      other.ratingsStatus == ratingsStatus &&
      other.ratingsError == ratingsError &&
      other.ratingsMoreError == ratingsMoreError &&
      other.loadratingsMoreStatus == loadratingsMoreStatus &&
      other.chapters == chapters &&
      other.chaptersStatus == chaptersStatus &&
      other.chaptersError == chaptersError &&
      other.chaptersMoreError == chaptersMoreError &&
      other.loadchaptersMoreStatus == loadchaptersMoreStatus &&
      other.hasMoreCourses == hasMoreCourses &&
      other.currentPage == currentPage &&
      other.courseDetails == courseDetails &&
      other.courseDetailsStatus == courseDetailsStatus &&
      other.courseDetailsError == courseDetailsError &&
      listEquals(other.universities, universities) &&
      other.universitiesState == universitiesState &&
      other.universitiesError == universitiesError &&
      listEquals(other.studyYears, studyYears) &&
      other.studyYearsStatus == studyYearsStatus &&
      other.studyYearsError == studyYearsError &&
      other.coursefilters == coursefilters &&
      other.isFavoriteError == isFavoriteError &&
      other.addRatingStatus == addRatingStatus &&
      other.addRatingError == addRatingError &&
      other.enrollStatus == enrollStatus &&
      other.enrollError == enrollError &&
      other.enrollStatusB == enrollStatusB &&
      listEquals(other.channels, channels) &&
      other.channelsStatus == channelsStatus &&
      other.channelsError == channelsError;
  }

  @override
  int get hashCode {
    return selectedIndex.hashCode ^
      categories.hashCode ^
      categoriesStatus.hashCode ^
      categoriesError.hashCode ^
      colleges.hashCode ^
      collegesStatus.hashCode ^
      collegesError.hashCode ^
      courses.hashCode ^
      coursesStatus.hashCode ^
      coursesError.hashCode ^
      coursesMoreError.hashCode ^
      loadCoursesMoreStatus.hashCode ^
      ratings.hashCode ^
      ratingsStatus.hashCode ^
      ratingsError.hashCode ^
      ratingsMoreError.hashCode ^
      loadratingsMoreStatus.hashCode ^
      chapters.hashCode ^
      chaptersStatus.hashCode ^
      chaptersError.hashCode ^
      chaptersMoreError.hashCode ^
      loadchaptersMoreStatus.hashCode ^
      hasMoreCourses.hashCode ^
      currentPage.hashCode ^
      courseDetails.hashCode ^
      courseDetailsStatus.hashCode ^
      courseDetailsError.hashCode ^
      universities.hashCode ^
      universitiesState.hashCode ^
      universitiesError.hashCode ^
      studyYears.hashCode ^
      studyYearsStatus.hashCode ^
      studyYearsError.hashCode ^
      coursefilters.hashCode ^
      isFavoriteError.hashCode ^
      addRatingStatus.hashCode ^
      addRatingError.hashCode ^
      enrollStatus.hashCode ^
      enrollError.hashCode ^
      enrollStatusB.hashCode ^
      channels.hashCode ^
      channelsStatus.hashCode ^
      channelsError.hashCode;
  }
}
