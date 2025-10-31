import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';

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
  //?------------------------------------------------------------
}
