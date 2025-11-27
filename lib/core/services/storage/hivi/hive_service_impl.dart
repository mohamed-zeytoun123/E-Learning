import 'package:e_learning/core/constant/cache_keys.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:hive/hive.dart';
import 'package:e_learning/core/services/storage/hivi/hive_service.dart';

class HiveServiceImpl implements HiveService {
  //?---------------- Category Box -------------------------

  late final Box<CategorieModel> _categoryBox;
  late final Box<CourseModel> _courseBox;
  late final Box<CollegeModel> _collegeBox;
  late final Box<UniversityModel> _universityBox;
  late final Box<StudyYearModel> _studyYearBox;
  late final Box<CourseFiltersModel> _courseFiltersBox;

  HiveServiceImpl() {
    _categoryBox = Hive.box<CategorieModel>(CacheKeys.categoryBox);
    _courseBox = Hive.box<CourseModel>(CacheKeys.courseBox);
    _collegeBox = Hive.box<CollegeModel>(CacheKeys.collegeBox);
    _universityBox = Hive.box<UniversityModel>(CacheKeys.universityBox);
    _studyYearBox = Hive.box<StudyYearModel>(CacheKeys.studyYearBox);
    _courseFiltersBox = Hive.box<CourseFiltersModel>(
      CacheKeys.courseFiltersBox,
    );
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

  //?---------------- University Box -------------------------

  //* Clear all universities
  @override
  Future<void> clearAllUniversitiesHive() async {
    await _universityBox.clear();
  }

  //* Save universities
  @override
  Future<void> saveUniversitiesHive(List<UniversityModel> universities) async {
    await _universityBox.clear();
    await _universityBox.addAll(universities);
  }

  //* Get all universities
  @override
  List<UniversityModel> getAllUniversitiesHive() {
    return _universityBox.values.toList();
  }

  //?---------------- StudyYear Box -------------------------

  //* Clear all study years
  @override
  Future<void> clearAllStudyYearsHive() async {
    await _studyYearBox.clear();
  }

  //* Save study years
  @override
  Future<void> saveStudyYearsHive(List<StudyYearModel> years) async {
    await _studyYearBox.clear();
    await _studyYearBox.addAll(years);
  }

  //* Get all study years
  @override
  List<StudyYearModel> getAllStudyYearsHive() {
    return _studyYearBox.values.toList();
  }

  //?---------------- filters Courses Box -------------------------

  //* Clear filters
  @override
  Future<void> clearCourseFiltersHive() async {
    await _courseFiltersBox.clear();
  }

  //* Save filters
  @override
  Future<void> saveCourseFiltersHive(CourseFiltersModel filters) async {
    await _courseFiltersBox.clear();
    await _courseFiltersBox.add(filters);
  }

  //* Get filters
  @override
  CourseFiltersModel? getCourseFiltersHive() {
    if (_courseFiltersBox.isNotEmpty) {
      return _courseFiltersBox.values.first;
    }
    return null;
  }

  //* Update filters
  @override
  Future<void> updateCourseFiltersHive(CourseFiltersModel filters) async {
    if (_courseFiltersBox.isNotEmpty) {
      final key = _courseFiltersBox.keys.first;
      await _courseFiltersBox.put(key, filters);
    } else {
      await _courseFiltersBox.add(filters);
    }
  }



  //?--------------------------------------------------------
}
