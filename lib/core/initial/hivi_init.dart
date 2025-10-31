import 'package:e_learning/core/constant/cache_keys.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';

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

  //? ---------------------------------------------------------------------
}
