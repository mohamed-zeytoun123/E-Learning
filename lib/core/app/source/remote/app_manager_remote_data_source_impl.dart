import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:e_learning/core/app/source/remote/app_manager_remote_data_source.dart';
import 'package:e_learning/core/services/token/token_service.dart';
import 'package:network/failures/failures.dart';
import 'package:network/network.dart';
import 'package:network/network/api/api_request.dart';

class AppManagerRemoteDataSourceImpl implements AppManagerRemoteDataSource {
  final API api;
  final TokenService tokenService;

  AppManagerRemoteDataSourceImpl({
    required this.api,
    required this.tokenService,
  });

  //?----------------------------------------------------------------------
  //* Logout
  @override
  Future<Either<Failure, bool>> logout() async {
    final request = ApiRequest(
      url: AppUrls.logOut,
      body: {"refresh": tokenService.getRefreshTokenService()},
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.post(request);
      if (response.statusCode == 200) {
        await tokenService.clearTokenService();
        return const Right(true);
      }
      return Left(Failure(message: response.message));
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //?----------------------------------------------------------------------
}
