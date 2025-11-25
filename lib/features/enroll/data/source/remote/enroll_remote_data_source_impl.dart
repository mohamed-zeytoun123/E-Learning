import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:e_learning/core/services/token/token_service.dart';
import 'package:e_learning/features/Course/data/models/enrollment_model.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_model.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_response.dart';
import 'package:e_learning/features/enroll/data/models/params/create_rating_params.dart';
import 'package:e_learning/features/enroll/data/models/params/get_course_ratings_params.dart';
import 'package:e_learning/features/enroll/data/source/remote/enroll_remote_data_source.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:netwoek/network.dart';
import 'package:netwoek/network/api/api_request.dart';

class EnrollRemoteDataSourceImpl implements EnrollRemoteDataSource {
  final API api;
  final TokenService tokenService;

  EnrollRemoteDataSourceImpl({
    required this.api,
    required this.tokenService,
  });

  /// Get authentication headers with token
  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await tokenService.getTokenService();
    log('🔑 Token retrieved: ${token != null ? "Token exists (${token.length} chars)" : "Token is NULL"}');

    // Start with base headers
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      // Use token from storage with Bearer prefix
      headers['Authorization'] = 'Bearer $token';
      log('🔑 Using token from storage with Bearer prefix');
    } else {
      // Fallback to ApiRequestParameters.authHeaders (hardcoded token)
      log('⚠️ No token in storage, using ApiRequestParameters.authHeaders');
      final hardcodedToken = ApiRequestParameters.authHeaders['Authorization']!;
      // Add Bearer prefix if not already present
      headers['Authorization'] = hardcodedToken.startsWith('Bearer ')
          ? hardcodedToken
          : 'Bearer $hardcodedToken';
      log('🔑 Using hardcoded Authorization from ApiRequestParameters with Bearer prefix');
    }

    log('🔑 Final headers: ${headers.keys.join(", ")}');
    log('🔑 Authorization present: ${headers.containsKey('Authorization')}');
    if (headers.containsKey('Authorization')) {
      final authValue = headers['Authorization']!;
      log('🔑 Authorization value length: ${authValue.length}');
      log('🔑 Authorization starts with: ${authValue.substring(0, authValue.length > 20 ? 20 : authValue.length)}...');
    }
    return headers;
  }

  @override
  Future<Either<Failure, List<EnrollmentModel>>> getMyCoursesRemote({
    int? page,
    int? pageSize,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {};
      if (page != null) queryParameters['page'] = page;
      if (pageSize != null) queryParameters['page_size'] = pageSize;

      final headers = await _getAuthHeaders();

      final response = await api.get(
        ApiRequest(
          url: AppUrls.myCourses,
          params: queryParameters.isNotEmpty ? queryParameters : null,
          headers: headers,
        ),
      );

      // Log response details for debugging
      log('📥 Response Status: ${response.statusCode}');
      log('📥 Response Success: ${response.success}');
      log('📥 Response Body Type: ${response.body.runtimeType}');
      log('📥 Response Body: ${response.body}');

      if (response.statusCode == 200 && response.body != null) {
        final body = response.body;

        List<dynamic> coursesList = [];

        // Handle different response structures
        if (body is List<dynamic>) {
          // Response is directly a list
          coursesList = body as List<dynamic>;
        } else if (body is Map) {
          // Response is wrapped in an object
          final results = body['results'];
          final data = body['data'];

          if (results is List<dynamic>) {
            coursesList = results;
          } else if (data is List<dynamic>) {
            coursesList = data;
          }
          // If no list found, coursesList remains empty
        }

        log('📥 Parsed coursesList length: ${coursesList.length}');

        final List<EnrollmentModel> enrollments = coursesList
            .map(
              (courseJson) =>
                  EnrollmentModel.fromJson(courseJson as Map<String, dynamic>),
            )
            .toList();

        log('📥 Final enrollments count: ${enrollments.length}');
        return Right(enrollments);
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error - Status: ${response.statusCode}, Body: ${response.body}';
        log('❌ Error: $errorMessage');
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception, stackTrace) {
      log('❌ Exception in getMyCoursesRemote: $exception');
      log('❌ StackTrace: $stackTrace');
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, CourseRatingResponse>> getCourseRatingsRemote(
    GetCourseRatingsParams params,
  ) async {
    try {
      final headers = await _getAuthHeaders();

      final response = await api.get(
        ApiRequest(
          url: AppUrls.courseRating(params.courseSlug),
          params: params.toQueryParams(),
          headers: headers,
        ),
      );

      if (response.statusCode == 200 && response.body != null) {
        final Map<String, dynamic> responseData =
            response.body as Map<String, dynamic>;

        final CourseRatingResponse ratingsResponse =
            CourseRatingResponse.fromJson(responseData);

        return Right(ratingsResponse);
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, CourseRatingModel>> createRatingRemote(
    CreateRatingParams params,
  ) async {
    try {
      final headers = await _getAuthHeaders();

      final response = await api.post(
        ApiRequest(
          url: AppUrls.courseRating(params.courseSlug),
          body: params.toJson(),
          headers: headers,
        ),
      );

      if (response.statusCode == 201 && response.body != null) {
        final Map<String, dynamic> responseData =
            response.body as Map<String, dynamic>;

        final CourseRatingModel rating = CourseRatingModel.fromJson(
          responseData,
        );

        return Right(rating);
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }
}
