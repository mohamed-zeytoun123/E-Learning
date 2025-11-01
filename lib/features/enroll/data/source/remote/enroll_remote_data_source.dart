import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_model.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_response.dart';
import 'package:e_learning/features/enroll/data/models/enrollment_model.dart';
import 'package:e_learning/features/enroll/data/models/params/create_rating_params.dart';
import 'package:e_learning/features/enroll/data/models/params/get_course_ratings_params.dart';

abstract class EnrollRemoteDataSource {
  /// Get user's enrolled courses
  Future<Either<Failure, List<EnrollmentModel>>> getMyCoursesRemote();

  /// Get course ratings with pagination
  Future<Either<Failure, CourseRatingResponse>> getCourseRatingsRemote(GetCourseRatingsParams params);

  /// Create a rating for a course
  Future<Either<Failure, CourseRatingModel>> createRatingRemote(CreateRatingParams params);
}
