import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';

abstract class HiveService {
  //?---------------- Category Box -------------------------
  Future<void> clearAllCategoriesHive();
  Future<void> saveCategoriesHive(List<CategorieModel> categories);
  List<CategorieModel> getAllCategoriesHive();

  //?---------------- Course Box ---------------------------
  Future<void> clearAllCoursesHive();
  Future<void> saveCoursesHive(List<CourseModel> courses);
  List<CourseModel> getAllCoursesHive();

  //?---------------- College Box ---------------------------
  Future<void> clearAllCollegesHive();
  Future<void> saveCollegesHive(List<CollegeModel> colleges);
  List<CollegeModel> getAllCollegesHive();

  //?---------------- Univesity Box ---------------------------
  Future<void> clearAllUniversitiesHive();
  Future<void> saveUniversitiesHive(List<UniversityModel> universities);
  List<UniversityModel> getAllUniversitiesHive();

  //?---------------- StudyYear Box -------------------------
  Future<void> clearAllStudyYearsHive();
  Future<void> saveStudyYearsHive(List<StudyYearModel> years);
  List<StudyYearModel> getAllStudyYearsHive();

  //?---------------- filters Courses Box -------------------------
  Future<void> clearCourseFiltersHive();
  Future<void> saveCourseFiltersHive(CourseFiltersModel filters);
  CourseFiltersModel? getCourseFiltersHive();
  Future<void> updateCourseFiltersHive(CourseFiltersModel filters);

  //?------------------------------------------------------------
}
