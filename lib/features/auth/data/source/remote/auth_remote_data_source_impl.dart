import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/core/model/response_model/auth_response_model.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/params/reset_password_request_params.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/auth/data/models/response/otp_verification_response.dart';
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
    required SignUpRequestParams params,
  }) async {
    try {
      final response = await api.post(
        ApiRequest(
          url: AppUrls.signUp,
          body: {
            "full_name": params.fullName,
            "university_id": params.universityId,
            "college_id": params.collegeId,
            "study_year": params.studyYear,
            "phone": params.phone,
            "password": params.password,
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

  //* getUniversities
  @override
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getUniversities);
      final ApiResponse response = await api.get(request);

      final List<UniversityModel> universities = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List) {
          for (var item in data) {
            universities.add(UniversityModel.fromMap(item));
          }
        }

        return Right(universities);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      return Left(Failure.handleError(exception as DioException));
    }
  }
  //? -----------------------------------------------------------------

  //* getColleges
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote({
    required int universityId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: '${AppUrls.getColleges}?university=$universityId',
      );

      final ApiResponse response = await api.get(request);
      final List<CollegeModel> colleges = [];

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is List) {
          for (var item in data) {
            colleges.add(CollegeModel.fromMap(item));
          }
        }
        return Right(colleges);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      return Left(Failure.handleError(exception as DioException));
    }
  }
  //? -----------------------------------------------------------------

  //* otp verfication
  @override
  Future<Either<Failure, OtpVerificationResponse>> otpVerficationRemote({
    required String phone,
    required String code,
    required String purpose,
  }) async {
    try {
      // Use different endpoints based on purpose
      String url;
      Map<String, dynamic> body;

      if (purpose == 'reset') {
        // For password reset:
        url = AppUrls.verifyForgotPasswordOtp;
        body = {"phone": phone, "code": code, "purpose": purpose};
      } else {
        // For registration:
        url = AppUrls.verifyOtp;
        body = {"phone": phone, "code": code, "purpose": purpose};
      }

      log("🔍 OTP Verification URL: $url");
      log("🔍 OTP Verification Body: $body");

      final response = await api.post(ApiRequest(url: url, body: body));

      if (response.statusCode == 200 && response.body != null) {
        log("🔍 OTP Verification Response: ${response.body}");

        // Parse the response based on purpose
        if (purpose == 'reset') {
          // For reset purpose, extract the reset_token
          final otpResponse = OtpVerificationResponse.fromJson(response.body);
          return Right(otpResponse);
        } else {
          // For registration purpose, return empty response
          return Right(OtpVerificationResponse());
        }
      }
      return Left(FailureServer());
    } catch (e) {
      log("error 🔥🔥🔥🔥🔥 OTP Verification:::$e");
      return Left(Failure.handleError(e as Exception));
    }
  }

  //? -----------------------------------------------------------------
  //* Forget Password

  @override
  Future<Either<Failure, bool>> forgetPasswordRemote({
    required String phone,
  }) async {
    try {
      final response = await api.post(
        ApiRequest(url: AppUrls.forgetPassword, body: {"phone": phone}),
      );
      if (response.statusCode == 200 && response.body != null) {
        return Right(true);
      }
      return Left(FailureServer());
    } catch (e) {
      log("error 🔥🔥🔥🔥🔥 :::$e");
      return Left(Failure.handleError(e as Exception));
    }
  }

  //? -----------------------------------------------------------------

  //* Reset Password
  @override
  Future<Either<Failure, bool>> resetPasswordRemote({
    required ResetPasswordRequestParams params,
  }) async {
    try {
      final response = await api.post(
        ApiRequest(url: AppUrls.resetPassword, body: params.toMap()),
      );
      if (response.statusCode == 200 && response.body != null) {
        return Right(true);
      }
      return Left(FailureServer());
    } catch (e) {
      log("error 🔥🔥🔥🔥🔥 Reset Password:::$e");
      return Left(Failure.handleError(e as Exception));
    }
  }

  //? -----------------------------------------------------------------
}
