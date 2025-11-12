import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_response_model.dart';
import 'package:e_learning/features/Teacher/data/source/remote/teacher_remote_data_source.dart';

class TeacherRemoteDataSourceImpl implements TeacherRemoteDataSource {
  final API api;

  TeacherRemoteDataSourceImpl({required this.api});

  //?----------------------------------------------------
  //* Get Teachers

  @override
  Future<Either<Failure, TeacherResponseModel>> getTeachersRemote({
    int? page,
    int? pageSize,
    String? search,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
        if (search != null && search.isNotEmpty) 'search': search,
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getTeachers,
        queryParameters: queryParameters,
      );

      log('🌐 Request URL: ${AppUrls.getTeachers}');
      log('🌐 Query Parameters: $queryParameters');

      final ApiResponse response = await api.get(request);

      log('📡 Teachers API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final teacherResponse = TeacherResponseModel.fromMap(data);
          log('✅ Successfully parsed ${teacherResponse.results.length} teachers');
          return Right(teacherResponse);
        } else {
          return Left(
            Failure(
              message: 'Unexpected response format',
              statusCode: response.statusCode,
            ),
          );
        }
      } else {
        String errorMessage = 'Unknown error';
        if (response.body is Map<String, dynamic>) {
          errorMessage =
              response.body['message']?.toString() ?? 'Unknown error';
        }
        return Left(
          Failure(
            message: errorMessage,
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?----------------------------------------------------
}
