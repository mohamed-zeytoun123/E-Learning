import 'package:e_learning/core/services/storage/hivi/hive_service.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';
import 'package:e_learning/features/course/data/source/local/courcese_local_data_source.dart';

class CourceseLocalDataSourceImpl implements CourceseLocalDataSource {
  final HiveService hive;

  CourceseLocalDataSourceImpl({required this.hive});

  //?--- Categories  -------------------------------------------------

  //* Get Categories From Cache
  @override
  List<CategorieModel> getCategoriesInCach() {
    try {
      final categories = hive.getAllCategoriesHive();
      return categories;
    } catch (e) {
      return [];
    }
  }

  //* Save Categories To Cache
  @override
  Future<void> saveCategoriesInCash(List<CategorieModel> categories) async {
    try {
      await hive.saveCategoriesHive(categories);
    } catch (_) {}
  }

  //?--- Courses -------------------------------------------------

  //* Get Courses From Cache
  @override
  List<CourseModel> getCoursesInCache() {
    try {
      final courses = hive.getAllCoursesHive();
      return courses;
    } catch (e) {
      return [];
    }
  }

  //* Save Courses To Cache
  @override
  Future<void> saveCoursesInCache(List<CourseModel> courses) async {
    try {
      await hive.saveCoursesHive(courses);
    } catch (_) {}
  }

  //?--- Colleges -------------------------------------------------

  //* Get Colleges From Cache
  @override
  List<CollegeModel> getCollegesInCache() {
    try {
      final colleges = hive.getAllCollegesHive();
      return colleges;
    } catch (e) {
      return [];
    }
  }

  //* Save Colleges To Cache
  @override
  Future<void> saveCollegesInCache(List<CollegeModel> colleges) async {
    try {
      await hive.saveCollegesHive(colleges);
    } catch (_) {}
  }

  //* Clear Colleges Cache
  Future<void> clearCollegesCache() async {
    try {
      await hive.clearAllCollegesHive();
    } catch (_) {}
  }

  //?--- Universities -------------------------------------------------

  //* Get Universities From Cache
  @override
  List<UniversityModel> getUniversitiesInCache() {
    try {
      final universities = hive.getAllUniversitiesHive();
      return universities;
    } catch (e) {
      return [];
    }
  }

  //* Save Universities To Cache
  @override
  Future<void> saveUniversitiesInCache(
    List<UniversityModel> universities,
  ) async {
    try {
      await hive.saveUniversitiesHive(universities);
    } catch (_) {}
  }

  //* Clear Universities Cache
  @override
  Future<void> clearUniversitiesCache() async {
    try {
      await hive.clearAllUniversitiesHive();
    } catch (_) {}
  }

  //?----------------------------------------------------
}
