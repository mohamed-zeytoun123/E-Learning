import 'package:e_learning/features/Course/data/models/course_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model.dart';

abstract class CourceseLocalDataSource {
  //?----------------------------------------------------
  //* Get Categories From Cache
  List<CategorieModel> getCategoriesInCach();
  Future<void> saveCategoriesInCash(List<CategorieModel> categories);

  //* Get Courses From Cache
  List<CourseModel> getCoursesInCache();
  Future<void> saveCoursesInCache(List<CourseModel> courses);
  Future<void> appendCoursesToCache(List<CourseModel> newCourses);

  //* Get Colleges From Cache
  List<CollegeModel> getCollegesInCache();
  Future<void> saveCollegesInCache(List<CollegeModel> colleges);

  //* Get Universities From Cache
  List<UniversityModel> getUniversitiesInCache();
  Future<void> saveUniversitiesInCache(List<UniversityModel> universities);

  //* Get Study Years From Cache
  List<StudyYearModel> getStudyYearsInCache();
  Future<void> saveStudyYearsInCache(List<StudyYearModel> years);

  //* Fillters
  Future<void> saveFilters(CourseFiltersModel filters);
  CourseFiltersModel? getFilters();
  Future<void> updateFilters(CourseFiltersModel filters);
  Future<void> clearFilters();
  //?----------------------------------------------------
}
