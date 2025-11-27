import 'package:e_learning/core/constant/cache_keys.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  //? ---------------- Initialize Hive -------------------------

  await Hive.initFlutter();

  //? ---------------- Register Adapters & Open Box -----------------------

  //* Category Model Adapter    index = 1
  Hive.registerAdapter(CategorieModelAdapter());
  await Hive.openBox<CategorieModel>(CacheKeys.categoryBox);

  //* Course Model Adapter     index = 2
  Hive.registerAdapter(CourseModelAdapter());
  await Hive.openBox<CourseModel>(CacheKeys.courseBox);

  //* College Model Adapter    index = 3
  Hive.registerAdapter(CollegeModelAdapter());
  await Hive.openBox<CollegeModel>(CacheKeys.collegeBox);

  //* University Model Adapter    index = 4
  Hive.registerAdapter(UniversityModelAdapter());
  await Hive.openBox<UniversityModel>(CacheKeys.universityBox);

  //* Study Year Model Adapter    index = 5
  Hive.registerAdapter(StudyYearModelAdapter());
  await Hive.openBox<StudyYearModel>(CacheKeys.studyYearBox);

  //* Course Filters Model Model Adapter    index = 6
  Hive.registerAdapter(CourseFiltersModelAdapter());
  await Hive.openBox<CourseFiltersModel>(CacheKeys.courseFiltersBox);

  //? ---------------------------------------------------------------------
}
