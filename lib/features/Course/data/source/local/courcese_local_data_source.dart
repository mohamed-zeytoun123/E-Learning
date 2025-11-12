import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_model/course_model.dart';

abstract class CourceseLocalDataSource {
  //?----------------------------------------------------
  //* Get Categories From Cache
  List<CategorieModel> getCategoriesInCach();
  Future<void> saveCategoriesInCash(List<CategorieModel> categories);

  //* Get Courses From Cache
  List<CourseModel> getCoursesInCache();
  Future<void> saveCoursesInCache(List<CourseModel> courses);

  //* Get Colleges From Cache
  List<CollegeModel> getCollegesInCache();
  Future<void> saveCollegesInCache(List<CollegeModel> colleges);

  //?----------------------------------------------------
}
