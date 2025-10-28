import 'package:e_learning/core/constant/cache_keys.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';
import 'package:hive/hive.dart';
import 'package:e_learning/core/services/storage/hivi/hive_service.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';

class HiveServiceImpl implements HiveService {
  //?---------------- Category Box -------------------------

  late final Box<CategorieModel> _categoryBox;
  late final Box<CourseModel> _courseBox;
  late final Box<CollegeModel> _collegeBox;

  HiveServiceImpl() {
    _categoryBox = Hive.box<CategorieModel>(CacheKeys.categoryBox);
    _courseBox = Hive.box<CourseModel>(CacheKeys.courseBox);
    _collegeBox = Hive.box<CollegeModel>(CacheKeys.collegeBox);
  }
  //?---------------- Category Box -------------------------

  //* Claer
  @override
  Future<void> clearAllCategoriesHive() async {
    await _categoryBox.clear();
  }

  //* Save
  @override
  Future<void> saveCategoriesHive(List<CategorieModel> categories) async {
    await _categoryBox.clear();
    await _categoryBox.addAll(categories);
  }

  //* Get
  @override
  List<CategorieModel> getAllCategoriesHive() {
    return _categoryBox.values.toList();
  }

  //?---------------- Course Box -------------------------

  //* Clear
  @override
  Future<void> clearAllCoursesHive() async {
    await _courseBox.clear();
  }

  //* Save
  @override
  Future<void> saveCoursesHive(List<CourseModel> courses) async {
    await _courseBox.clear();
    await _courseBox.addAll(courses);
  }

  //* Get
  @override
  List<CourseModel> getAllCoursesHive() {
    return _courseBox.values.toList();
  }
  //?---------------- College Box -------------------------

  //* Clear all colleges
  @override
  Future<void> clearAllCollegesHive() async {
    await _collegeBox.clear();
  }

  //* Save colleges
  @override
  Future<void> saveCollegesHive(List<CollegeModel> colleges) async {
    await _collegeBox.clear();
    await _collegeBox.addAll(colleges);
  }

  //* Get all colleges
  @override
  List<CollegeModel> getAllCollegesHive() {
    return _collegeBox.values.toList();
  }

  //?--------------------------------------------------------
}
