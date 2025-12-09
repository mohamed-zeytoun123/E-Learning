import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';
import 'package:e_learning/features/Course/data/models/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';

abstract class CourceseRepository {
  //?-------------------------------------------------
  //* Get Filter Categories
  Future<Either<Failure, List<CategorieModel>>> getFilterCategoriesRepo();

  //* Get Courses (supports both paginated and non-paginated)
  Future<Either<Failure, dynamic>> getCoursesRepo({
    int? categoryId,
    int? collegeId,
    int? studyYear,
    int? teacherId,
    String? search,
    String? ordering,
    CourseFiltersModel? filters,
    int? page,
    int? pageSize,
  });

  //* Get Colleges
  Future<Either<Failure, List<CollegeModel>>> getCollegesRepo();

  //* Get Course Details
  Future<Either<Failure, CourseDetailsModel>> getCourseDetailsRepo({
    required String courseSlug,
  });

  //* Get Chapters by Course
  Future<Either<Failure, List<ChapterModel>>> getChaptersRepo({
    required int courseId,
  });
  //?-------------------------------------------------
}
