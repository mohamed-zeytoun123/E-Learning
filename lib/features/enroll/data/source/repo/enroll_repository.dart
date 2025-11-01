import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_model.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_response.dart';
import 'package:e_learning/features/enroll/data/models/enrollment_model.dart';
import 'package:e_learning/features/enroll/data/models/params/create_rating_params.dart';
import 'package:e_learning/features/enroll/data/models/params/get_course_ratings_params.dart';

abstract class EnrollRepository {
  /// Get user's enrolled courses
  Future<Either<Failure, List<EnrollmentModel>>> getMyCoursesRepo();

  /// Get course ratings with pagination
  Future<Either<Failure, CourseRatingResponse>> getCourseRatingsRepo(GetCourseRatingsParams params);

  /// Create a rating for a course
  Future<Either<Failure, CourseRatingModel>> createRatingRepo(CreateRatingParams params);
}
