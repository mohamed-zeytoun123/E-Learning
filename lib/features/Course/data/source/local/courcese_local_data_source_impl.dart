import 'package:e_learning/core/services/storage/hivi/hive_service.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';

import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';
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
      return hive.getAllCoursesHive();
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

  //* Append Courses To Cache (add new page courses)
  @override
  Future<void> appendCoursesToCache(List<CourseModel> newCourses) async {
    try {
      // جلب الكورسات القديمة من الكاش
      final existingCourses = hive.getAllCoursesHive();

      // دمج الكورسات القديمة مع الجديدة بدون تكرار
      final allCourses = [
        ...existingCourses,
        ...newCourses.where(
          (newCourse) => !existingCourses.any((old) => old.id == newCourse.id),
        ),
      ];

      // حفظ الكل بالكاش من جديد
      await hive.saveCoursesHive(allCourses);
    } catch (e) {
      // بتجاهل الخطأ بس للتأكد إنو التطبيق ما ينهار
    }
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
  Future<void> clearUniversitiesCache() async {
    try {
      await hive.clearAllUniversitiesHive();
    } catch (_) {}
  }

  //?--- Study Years -------------------------------------------------

  //* Get Study Years From Cache
  @override
  List<StudyYearModel> getStudyYearsInCache() {
    try {
      return hive.getAllStudyYearsHive();
    } catch (e) {
      return [];
    }
  }

  //* Save Study Years To Cache
  @override
  Future<void> saveStudyYearsInCache(List<StudyYearModel> years) async {
    try {
      await hive.saveStudyYearsHive(years);
    } catch (_) {}
  }

  //* Clear Study Years Cache
  Future<void> clearStudyYearsCache() async {
    try {
      await hive.clearAllStudyYearsHive();
    } catch (_) {}
  }

  //?--- Filters -------------------------------------------------
  @override
  Future<void> saveFilters(CourseFiltersModel filters) async {
    try {
      await hive.clearCourseFiltersHive();
      await hive.saveCourseFiltersHive(filters);
    } catch (e) {
      // تجاهل الخطأ أو تسجيله
    }
  }

  @override
  CourseFiltersModel? getFilters() {
    try {
      return hive.getCourseFiltersHive();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateFilters(CourseFiltersModel filters) async {
    try {
      await hive.updateCourseFiltersHive(filters);
    } catch (e) {
      // تجاهل الخطأ
    }
  }

  @override
  Future<void> clearFilters() async {
    try {
      await hive.clearCourseFiltersHive();
    } catch (e) {
      // تجاهل الخطأ
    }
  }

  //?----------------------------------------------------
}
