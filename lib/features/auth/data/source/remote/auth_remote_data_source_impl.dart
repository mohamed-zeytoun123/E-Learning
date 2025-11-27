import 'package:dartz/dartz.dart';
import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:network/failures/failures.dart';
import 'package:e_learning/core/model/auth_response_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/params/reset_password_request_params.dart';
import 'package:e_learning/features/auth/data/models/response/otp_verification_response.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/auth/data/source/remote/auth_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:network/network.dart';
import 'package:network/network/api/api_call_manager.dart';
import 'package:network/network/api/api_request.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final API api;
  final APICallManager apiCallManager;

  AuthRemoteDataSourceImpl({
    required this.api,
    required this.apiCallManager,
  });
  //? -------------------------------------------------------------------------------------

  //* LogIn
  @override
  Future<Either<Failure, AuthResponseModel>> loginRemote(
    String numberPhone,
    String password,
  ) async {
    final request = ApiRequest(
      url: AppUrls.login,
      body: {"email": numberPhone, "password": password},
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.post(request);
      if (response.statusCode == 200 && response.body != null) {
        final data = response.body!['data'] ?? response.body;
        final userData =
            AuthResponseModel.fromMap(data as Map<String, dynamic>);
        return Right(userData);
      } else {
        // Extract error message from response body - check for detail, message, error, errors
        final body = response.body;
        String errorMessage = 'Login failed. Please try again.';
        if (body is Map) {
          if (body.containsKey('detail')) {
            errorMessage = body['detail'].toString();
          } else if (body.containsKey('message')) {
            errorMessage = body['message'].toString();
          } else if (body.containsKey('error')) {
            errorMessage = body['error'].toString();
          } else if (body.containsKey('errors')) {
            errorMessage = body['errors'].toString();
          }
        }
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //? ---------------------------------------------------------------------------------------

  //* signUp
  @override
  Future<Either<Failure, AuthResponseModel>> signUpRemote({
    required SignUpRequestParams params,
  }) async {
    final request = ApiRequest(
      url: AppUrls.signUp,
      body: {
        "full_name": params.fullName,
        "university_id": params.universityId,
        "college_id": params.collegeId,
        "study_year": params.studyYear,
        "phone": params.phone,
        "password": params.password,
      },
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.post(request);
      if (response.statusCode == 200 && response.body != null) {
        final data = response.body!['data'] ?? response.body;
        final userData =
            AuthResponseModel.fromMap(data as Map<String, dynamic>);
        return Right(userData);
      }
      return Left(Failure(message: response.message));
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //? -----------------------------------------------------------------

  //* getUniversities
  @override
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRemote() async {
    final request = ApiRequest(
      url: AppUrls.getUniversities,
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.get(request);
      if (response.statusCode == 200 && response.body != null) {
        final data = response.body!['data'] ?? response.body;
        final List<UniversityModel> universities = [];
        if (data is List) {
          for (var item in data) {
            universities
                .add(UniversityModel.fromMap(item as Map<String, dynamic>));
          }
        }
        return Right(universities);
      }
      return Left(Failure(message: response.message));
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }
  //? -----------------------------------------------------------------

  //* getColleges
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote({
    required int universityId,
  }) async {
    final request = ApiRequest(
      url: '${AppUrls.getColleges}?university=$universityId',
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.get(request);
      if (response.statusCode == 200 && response.body != null) {
        final data = response.body!['data'] ?? response.body;
        final List<CollegeModel> colleges = [];
        if (data is List) {
          for (var item in data) {
            colleges.add(CollegeModel.fromMap(item as Map<String, dynamic>));
          }
        }
        return Right(colleges);
      }
      return Left(Failure(message: response.message));
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
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
    // Use different endpoints based on purpose
    final url = purpose == 'reset'
        ? AppUrls.verifyForgotPasswordOtp
        : AppUrls.verifyOtp;

    final request = ApiRequest(
      url: url,
      body: {"phone": phone, "code": code, "purpose": purpose},
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.post(request);
      if (response.statusCode == 200 && response.body != null) {
        final data = response.body!['data'] ?? response.body;
        if (purpose == 'reset') {
          final otpResponse =
              OtpVerificationResponse.fromJson(data as Map<String, dynamic>);
          return Right(otpResponse);
        } else {
          return Right(OtpVerificationResponse());
        }
      }
      return Left(Failure(message: response.message));
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //? -----------------------------------------------------------------
  //* Forget Password

  @override
  Future<Either<Failure, bool>> forgetPasswordRemote({
    required String phone,
  }) async {
    final request = ApiRequest(
      url: AppUrls.forgetPassword,
      body: {"phone": phone},
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.post(request);
      if (response.statusCode == 200 && response.body != null) {
        return const Right(true);
      }
      return Left(Failure(message: 'Failed to send password reset'));
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //? -----------------------------------------------------------------

  //* Reset Password
  @override
  Future<Either<Failure, bool>> resetPasswordRemote({
    required ResetPasswordRequestParams params,
  }) async {
    final request = ApiRequest(
      url: AppUrls.resetPassword,
      body: params.toMap(),
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.post(request);
      if (response.statusCode == 200 && response.body != null) {
        return const Right(true);
      }
      return Left(Failure(message: 'Failed to reset password'));
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logOutRemote(String refreshToken) async {
    final request = ApiRequest(
      url: AppUrls.logOut,
      body: {"refresh": refreshToken},
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.post(request);
      if (response.statusCode == 200 && response.body != null) {
        return const Right(true);
      }
      return Left(Failure(message: 'Failed to logout'));
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //? -----------------------------------------------------------------

  //* getStudyYears
  @override
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRemote() async {
    final request = ApiRequest(
      url: AppUrls.getStudyYears,
      headers: ApiRequestParameters.noAuthHeaders,
    );

    try {
      final response = await api.get(request);
      if (response.statusCode == 200 && response.body != null) {
        final data = response.body!['data'] ?? response.body;
        final List<StudyYearModel> studyYears = [];
        if (data is Map<String, dynamic> && data['results'] is List) {
          for (var item in data['results']) {
            studyYears
                .add(StudyYearModel.fromJson(item as Map<String, dynamic>));
          }
        } else if (data is List) {
          for (var item in data) {
            studyYears
                .add(StudyYearModel.fromJson(item as Map<String, dynamic>));
          }
        }
        return Right(studyYears);
      }
      return Left(Failure(message: response.message));
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //? -----------------------------------------------------------------
}
