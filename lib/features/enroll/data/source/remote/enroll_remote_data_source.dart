import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/enroll/data/models/enrollment_model.dart';

abstract class EnrollRemoteDataSource {
  /// Get user's enrolled courses
  Future<Either<Failure, List<EnrollmentModel>>> getMyCourses();
}
