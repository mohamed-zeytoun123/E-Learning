import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/core/model/response_model/auth_response_model.dart';
import 'package:e_learning/features/auth/data/source/remote/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final API api;

  AuthRemoteDataSourceImpl({required this.api});
  //? -------------------------------------------------------------------------------------

  //* LogIn
  @override
  Future<Either<Failure, AuthResponseModel>> loginRemote(
    String numberPhone,
    String password,
  ) async {
    try {
      final response = await api.post(
        ApiRequest(
          url: AppUrls.login,
          body: {"phone": numberPhone, "password": password},
        ),
      );
      if (response.statusCode == 200 && response.body != null) {
        final userData = AuthResponseModel.fromMap(response.body);
        return Right(userData);
      }
      return Left(FailureServer());
    } catch (e) {
      log("error 🔥🔥🔥🔥🔥 :::$e");
      return Left(Failure.handleError(e as Exception));
    }
  }

  //? ---------------------------------------------------------------------------------------

  //* signUp
  @override
  Future<Either<Failure, AuthResponseModel>> signUpRemote({
    required String fullName,
    required int universityId,
    required int collegeId,
    required int studyYear,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await api.post(
        ApiRequest(
          url: AppUrls.signUp,
          body: {
            "full_name": fullName,
            "university_id": universityId,
            "college_id": collegeId,
            "study_year": studyYear,
            "phone": phone,
            "password": password,
          },
        ),
      );

      if (response.statusCode == 200 && response.body != null) {
        final userData = AuthResponseModel.fromMap(response.body);
        return Right(userData);
      }
      return Left(FailureServer());
    } catch (e) {
      log("🔥🔥 Error in register: $e");
      return Left(Failure.handleError(e as Exception));
    }
  }

  //? -----------------------------------------------------------------

  //? -----------------------------------------------------------------
}
