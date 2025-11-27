import 'package:dartz/dartz.dart';

import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Course/data/models/enrollment_model.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_model.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_response.dart';
import 'package:e_learning/features/enroll/data/models/params/create_rating_params.dart';
import 'package:e_learning/features/enroll/data/models/params/get_course_ratings_params.dart';
import 'package:e_learning/features/enroll/data/source/local/enroll_local_data_source.dart';
import 'package:e_learning/features/enroll/data/source/remote/enroll_remote_data_source.dart';
import 'package:e_learning/features/enroll/data/source/repo/enroll_repository.dart';
import 'package:network/failures/failures.dart';

class EnrollRepositoryImpl implements EnrollRepository {
  final EnrollRemoteDataSource remoteDataSource;
  final EnrollLocalDataSource localDataSource;
  final NetworkInfoService networkInfo;

  EnrollRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<EnrollmentModel>>> getMyCoursesRepo({
    int? page,
    int? pageSize,
  }) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getMyCoursesRemote(
        page: page,
        pageSize: pageSize,
      );

      return result.fold((failure) => Left(failure), (enrollments) async {
        // Save to local cache
        await localDataSource.saveEnrollmentsLocal(enrollments);
        return Right(enrollments);
      });
    } else {
      // Try to get from local cache when offline
      try {
        final cachedEnrollments = await localDataSource.getEnrollmentsLocal();
        if (cachedEnrollments != null && cachedEnrollments.isNotEmpty) {
          return Right(cachedEnrollments);
        } else {
          return Left(Failure(message: 'No internet connection and no cached data'));
        }
      } catch (e) {
        return Left(Failure(message: 'No internet connection and no cached data'));
      }
    }
  }

  @override
  Future<Either<Failure, CourseRatingResponse>> getCourseRatingsRepo(
    GetCourseRatingsParams params,
  ) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getCourseRatingsRemote(params);

      return result.fold((failure) => Left(failure), (ratingResponse) async {
        // Save ratings to local cache
        await localDataSource.saveCourseRatingsLocal(
          params.courseSlug,
          ratingResponse,
        );
        return Right(ratingResponse);
      });
    } else {
      // Try to get from local cache when offline
      try {
        final cachedResponse = await localDataSource.getCourseRatingsLocal(
          params.courseSlug,
        );
        if (cachedResponse != null) {
          return Right(cachedResponse);
        } else {
          return Left(Failure(message: 'No internet connection and no cached data'));
        }
      } catch (e) {
        return Left(Failure(message: 'No internet connection and no cached data'));
      }
    }
  }

  @override
  Future<Either<Failure, CourseRatingModel>> createRatingRepo(
    CreateRatingParams params,
  ) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.createRatingRemote(params);

      return result.fold((failure) => Left(failure), (rating) async {
        // For now, just return the rating without local storage for individual ratings
        // The rating will be cached when we fetch the course ratings next time
        return Right(rating);
      });
    } else {
      return Left(Failure(message: 'No internet connection'));
    }
  }
}

