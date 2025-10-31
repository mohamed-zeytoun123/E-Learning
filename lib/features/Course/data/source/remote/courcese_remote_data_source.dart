import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/Course/data/models/rating_model.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/course/data/models/course_details_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';

abstract class CourceseRemoteDataSource {
  //?----------------------------------------------------

  //* Get Filter Categories
  Future<Either<Failure, List<CategorieModel>>> getFilterCategoriesRemote();

  //* Get Courses
  Future<Either<Failure, List<CourseModel>>> getCoursesRemote({
    int? collegeId,
    int? studyYear,
    int? categoryId,
    int? teacherId,
    String? search,
    String? ordering,
  });

  //* Get Colleges
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote();

  //* Get Course Details by Slug
  Future<Either<Failure, CourseDetailsModel>> getCourseDetailsRemote({
    required String courseSlug,
  });

  //* Get Chapters by Slug
  Future<Either<Failure, List<ChapterModel>>> getChaptersRemote({
    required String courseSlug,
  });

  //* Get Ratings by Slug
  Future<Either<Failure, List<RatingModel>>> getRatingsRemote({
    required String courseSlug,
  });

  //* Get Universities
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRemote();

  //?----------------------------------------------------
}
