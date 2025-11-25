import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/features/Course/data/models/courses_result_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/enrollment_model.dart';
import 'package:e_learning/features/Course/data/models/rating_model.dart';
import 'package:e_learning/features/Course/data/models/ratings_result_model.dart';

import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapters_result_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';

abstract class CourceseRepository {
  //?-------------------------------------------------
  //* Get Filter Categories
  Future<Either<Failure, List<CategorieModel>>> getCategoriesRepo();

  //* Get Courses
  Future<Either<Failure, CoursesResultModel>> getCoursesRepo({
    CourseFiltersModel? filters,
    int? teacherId,
    String? search,
    String? ordering,
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
  Future<Either<Failure, ChaptersResultModel>> getChaptersRepo({
    required String courseId,
    int? page,
    int? pageSize,
  });

  //* Get Ratings by Course (Repository)
  Future<Either<Failure, RatingsResultModel>> getRatingsRepo({
    required String courseId,
    int? page,
    int? pageSize,
    String? ordering,
  });

  //* Get Universities
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRepo();

  //* Toggle Favorite Course
  Future<Either<Failure, bool>> toggleFavoriteCourseRepo({
    required String courseSlug,
  });

  //* Get Study Years
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRepo();

  //* Add Rating
  Future<Either<Failure, RatingModel>> addRatingRepo({
    required int rating,
    required String courseId,
    String? comment,
  });

  //* Enroll in a Course
  Future<Either<Failure, EnrollmentModel>> enrollCourseRepo({
    required int courseId,
  });
  //?-------------------------------------------------
}
