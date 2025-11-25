import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_response_model.dart';
import 'package:e_learning/features/Teacher/data/source/remote/teacher_remote_data_source.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:netwoek/network.dart';
import 'package:netwoek/network/api/api_request.dart';
import 'package:netwoek/network/api/api_response.dart';

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
        params: queryParameters,
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final teacherResponse = TeacherResponseModel.fromMap(data);
          return Right(teacherResponse);
        } else {
          return Left(
            Failure(
              message: 'Unexpected response format',
              errorCode: response.statusCode,
            ),
          );
        }
      } else {
        final body = response.body;
        final errorMessage = (body is Map<String, dynamic> && body['message'] != null)
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

  //?----------------------------------------------------
}
