import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/app/source/remote/app_manager_remote_data_source.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/core/services/token/token_service.dart';

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
    try {
      final response = await api.post(
        ApiRequest(
          url: AppUrls.logOut,
          body: {"refresh": tokenService.getRefreshTokenService()},
        ),
      );

      if (response.statusCode == 200) {
        await tokenService.clearTokenService();
        return const Right(true);
      }

      return Left(FailureServer());
    } catch (e) {
      log("🔥🔥 Error in logout: $e");
      return Left(Failure.handleError(e as Exception   )    );
    }
  }

  //?----------------------------------------------------------------------
}
