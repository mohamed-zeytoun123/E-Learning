
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';

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
