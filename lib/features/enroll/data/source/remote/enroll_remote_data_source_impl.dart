import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_model.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_response.dart';
import 'package:e_learning/features/enroll/data/models/enrollment_model.dart';
import 'package:e_learning/features/enroll/data/models/params/create_rating_params.dart';
import 'package:e_learning/features/enroll/data/models/params/get_course_ratings_params.dart';
import 'package:e_learning/features/enroll/data/source/remote/enroll_remote_data_source.dart';

class EnrollRemoteDataSourceImpl implements EnrollRemoteDataSource {
  final API api;

  EnrollRemoteDataSourceImpl({required this.api});

  @override
  Future<Either<Failure, List<EnrollmentModel>>> getMyCoursesRemote() async {
    try {
      final response = await api.get(ApiRequest(url: AppUrls.myCourses));

      if (response.statusCode == 200 && response.body != null) {
        final Map<String, dynamic> responseData =
            response.body as Map<String, dynamic>;
        final List<dynamic> coursesList =
            responseData['results'] as List<dynamic>;
        final List<EnrollmentModel> enrollments = coursesList
            .map(
              (courseJson) =>
                  EnrollmentModel.fromJson(courseJson as Map<String, dynamic>),
            )
            .toList();

        return Right(enrollments);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log("🔥🔥 Error in getMyCourses: $exception");
      return Left(Failure.handleError(exception as Exception));
    }
  }

  @override
  Future<Either<Failure, CourseRatingResponse>> getCourseRatingsRemote(GetCourseRatingsParams params) async {
    try {
      final response = await api.get(
        ApiRequest(
          url: AppUrls.courseRating(params.courseSlug),
          queryParameters: params.toQueryParams(),
        ),
      );

      if (response.statusCode == 200 && response.body != null) {
        final Map<String, dynamic> responseData =
            response.body as Map<String, dynamic>;
        final CourseRatingResponse ratingsResponse = CourseRatingResponse.fromJson(responseData);

        return Right(ratingsResponse);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log("🔥🔥 Error in getCourseRatings: $exception");
      return Left(Failure.handleError(exception as Exception));
    }
  }

  @override
  Future<Either<Failure, CourseRatingModel>> createRatingRemote(CreateRatingParams params) async {
    try {
      final response = await api.post(
        ApiRequest(
          url: AppUrls.courseRating(params.courseSlug),
          body: params.toJson(),
        ),
      );

      if (response.statusCode == 201 && response.body != null) {
        final Map<String, dynamic> responseData =
            response.body as Map<String, dynamic>;
        final CourseRatingModel rating = CourseRatingModel.fromJson(responseData);

        return Right(rating);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log("🔥🔥 Error in createRating: $exception");
      return Left(Failure.handleError(exception as Exception));
    }
  }
}
