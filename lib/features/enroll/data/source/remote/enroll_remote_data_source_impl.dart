import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/enroll/data/models/enrollment_model.dart';
import 'package:e_learning/features/enroll/data/source/remote/enroll_remote_data_source.dart';

class EnrollRemoteDataSourceImpl implements EnrollRemoteDataSource {
  final API api;

  EnrollRemoteDataSourceImpl({required this.api});

  @override
  Future<Either<Failure, List<EnrollmentModel>>> getMyCourses() async {
    try {
      final response = await api.get(ApiRequest(url: AppUrls.myCourses));

      if (response.statusCode == 200 && response.body != null) {
        final List<dynamic> coursesList = response.body as List<dynamic>;
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
      log("error 🔥🔥🔥🔥🔥 :::$exception");
      return Left(Failure.handleError(exception as DioException));
    }
  }
}
