import 'package:e_learning/core/constant/cache_keys.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';

Future<void> initHive() async {
  //? ---------------- Initialize Hive -------------------------
  await Hive.initFlutter();

  //? ---------------- Register Adapters & Open Box -----------------------

  //* Category Model Adapter
  Hive.registerAdapter(CategorieModelAdapter());
  await Hive.openBox<CategorieModel>(CacheKeys.categoryBox);

  //* Course Model Adapter
  Hive.registerAdapter(CourseModelAdapter());
  await Hive.openBox<CourseModel>(CacheKeys.courseBox);

  //* College Model Adapter
  Hive.registerAdapter(CollegeModelAdapter());
  await Hive.openBox<CollegeModel>(CacheKeys.collegeBox);

  //? ---------------------------------------------------------------------
}
