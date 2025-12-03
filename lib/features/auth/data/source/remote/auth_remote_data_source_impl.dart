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
import 'package:e_learning/features/auth/data/models/study_year_model/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
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
      } else if (response.statusCode != 200 && response.body != null) {
        // Handle error response with message from server
        String errorMessage = 'Login failed';
        
        if (response.body is Map<String, dynamic>) {
          final body = response.body as Map<String, dynamic>;
          
          // Try to extract error message from common error fields
          if (body.containsKey('detail') && body['detail'] != null) {
            errorMessage = body['detail'].toString();
          } else if (body.containsKey('message') && body['message'] != null) {
            errorMessage = body['message'].toString();
          } else if (body.containsKey('non_field_errors') && body['non_field_errors'] is List && (body['non_field_errors'] as List).isNotEmpty) {
            errorMessage = (body['non_field_errors'] as List).first.toString();
          } else if (body.isNotEmpty) {
            // Try to get the first error message
            final firstEntry = body.entries.first;
            if (firstEntry.value is String) {
              errorMessage = firstEntry.value.toString();
            } else if (firstEntry.value is List && (firstEntry.value as List).isNotEmpty) {
              errorMessage = (firstEntry.value as List).first.toString();
            }
          }
        }
        
        return Left(Failure(statusCode: response.statusCode, message: errorMessage));
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
            "email": params.email,
            "password": params.password,
          },
        ),
      );

      if (response.statusCode == 200 && response.body != null) {
        final userData = AuthResponseModel.fromMap(response.body);
        return Right(userData);
      } else if (response.statusCode != 200 && response.body != null) {
        // Handle error response with message from server
        String errorMessage = 'Sign up failed';
        
        if (response.body is Map<String, dynamic>) {
          final body = response.body as Map<String, dynamic>;
          
          // Try to extract error message from common error fields
          if (body.containsKey('detail') && body['detail'] != null) {
            errorMessage = body['detail'].toString();
          } else if (body.containsKey('message') && body['message'] != null) {
            errorMessage = body['message'].toString();
          } else if (body.containsKey('non_field_errors') && body['non_field_errors'] is List && (body['non_field_errors'] as List).isNotEmpty) {
            errorMessage = (body['non_field_errors'] as List).first.toString();
          } else if (body.isNotEmpty) {
            // Try to get the first error message
            final firstEntry = body.entries.first;
            if (firstEntry.value is String) {
              errorMessage = firstEntry.value.toString();
            } else if (firstEntry.value is List && (firstEntry.value as List).isNotEmpty) {
              errorMessage = (firstEntry.value as List).first.toString();
            }
          }
        }
        
        return Left(Failure(statusCode: response.statusCode, message: errorMessage));
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

      if (response.statusCode != 200) {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }

      final data = response.body;
      final List<UniversityModel> universities = [];

      // 🟢 الحالة الأساسية: response.body = Map وفيه key اسمه "results"
      if (data is Map<String, dynamic>) {
        final results = data['results'];
        if (results is List) {
          for (final item in results) {
            universities.add(UniversityModel.fromMap(item));
          }
        }
      }
      // 🟡 حالة احتياط: لو رجع List بدون Pagination
      else if (data is List) {
        for (final item in data) {
          universities.add(UniversityModel.fromMap(item));
        }
      }

      return Right(universities);
    } catch (exception) {
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //? -----------------------------------------------------------------
  //* getColleges
  //* getColleges
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote({
    required int universityId,
  }) async {
    try {
      final String url =
          '${AppUrls.getColleges}?page=1&page_size=10000&university=$universityId';

      final ApiRequest request = ApiRequest(url: url);

      final ApiResponse response = await api.get(request);
      final List<CollegeModel> colleges = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data['results'] is List) {
          colleges.addAll(
            (data['results'] as List)
                .map((item) => CollegeModel.fromMap(item))
                .toList(),
          );
        } else if (data is List) {
          colleges.addAll(data.map((item) => CollegeModel.fromMap(item)));
        }

        return Right(colleges);
      } else {
        return Left(
          Failure(
            message: (response.body is Map && response.body['message'] != null)
                ? response.body['message'].toString()
                : 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure.handleError(e));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  //? -----------------------------------------------------------------

  // otp verfication
  @override
  Future<Either<Failure, OtpVerificationResponse>> otpVerficationRemote({
    required String email,
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
        body = {"email": email, "code": code, "purpose": purpose};
      } else {
        // For registration:
        url = AppUrls.verifyOtp;
        body = {"email": email, "code": code, "purpose": purpose};
      }

      final response = await api.post(ApiRequest(url: url, body: body));

      if (response.statusCode == 200 && response.body != null) {
        // Parse the response based on purpose
        if (purpose == 'reset') {
          // For reset purpose, extract the reset_token
          final otpResponse = OtpVerificationResponse.fromJson(response.body);
          return Right(otpResponse);
        } else {
          // For registration purpose, return empty response
          return Right(OtpVerificationResponse());
        }
      } else if (response.statusCode != 200 && response.body != null) {
        // Handle error response with message from server
        String errorMessage = 'OTP verification failed';
        
        if (response.body is Map<String, dynamic>) {
          final body = response.body as Map<String, dynamic>;
          
          // Try to extract error message from common error fields
          if (body.containsKey('detail') && body['detail'] != null) {
            errorMessage = body['detail'].toString();
          } else if (body.containsKey('message') && body['message'] != null) {
            errorMessage = body['message'].toString();
          } else if (body.containsKey('non_field_errors') && body['non_field_errors'] is List && (body['non_field_errors'] as List).isNotEmpty) {
            errorMessage = (body['non_field_errors'] as List).first.toString();
          } else if (body.isNotEmpty) {
            // Try to get the first error message
            final firstEntry = body.entries.first;
            if (firstEntry.value is String) {
              errorMessage = firstEntry.value.toString();
            } else if (firstEntry.value is List && (firstEntry.value as List).isNotEmpty) {
              errorMessage = (firstEntry.value as List).first.toString();
            }
          }
        }
        
        return Left(Failure(statusCode: response.statusCode, message: errorMessage));
      }
      return Left(FailureServer());
    } catch (e) {
      log("error 🔥🔥🔥🔥🔥 OTP Verification:::$e");
      return Left(Failure.handleError(e as Exception));
    }
  }

  //* Resend Otp
  @override
  Future<Either<Failure, bool>> resendOtpRemote({
    required String email,
    required String purpose,
  }) async {
    try {
      final response = await api.post(
        ApiRequest(
          url: AppUrls.resendOtp,
          body: {"email": email, "purpose": purpose},
        ),
      );

      if (response.statusCode == 200 && response.body != null) {
        return Right(true);
      } else if (response.statusCode != 200 && response.body != null) {
        // Handle error response with message from server
        String errorMessage = 'Failed to resend OTP';
        
        if (response.body is Map<String, dynamic>) {
          final body = response.body as Map<String, dynamic>;
          
          // Try to extract error message from common error fields
          if (body.containsKey('detail') && body['detail'] != null) {
            errorMessage = body['detail'].toString();
          } else if (body.containsKey('message') && body['message'] != null) {
            errorMessage = body['message'].toString();
          } else if (body.containsKey('non_field_errors') && body['non_field_errors'] is List && (body['non_field_errors'] as List).isNotEmpty) {
            errorMessage = (body['non_field_errors'] as List).first.toString();
          } else if (body.isNotEmpty) {
            // Try to get the first error message
            final firstEntry = body.entries.first;
            if (firstEntry.value is String) {
              errorMessage = firstEntry.value.toString();
            } else if (firstEntry.value is List && (firstEntry.value as List).isNotEmpty) {
              errorMessage = (firstEntry.value as List).first.toString();
            }
          }
        }
        
        return Left(Failure(statusCode: response.statusCode, message: errorMessage));
      }
      return Left(FailureServer());
    } catch (e) {
      log("error 🔥🔥🔥🔥🔥 Resend OTP:::$e");
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
      } else if (response.statusCode != 200 && response.body != null) {
        // Handle error response with message from server
        String errorMessage = 'Failed to send reset password link';
        
        if (response.body is Map<String, dynamic>) {
          final body = response.body as Map<String, dynamic>;
          
          // Try to extract error message from common error fields
          if (body.containsKey('detail') && body['detail'] != null) {
            errorMessage = body['detail'].toString();
          } else if (body.containsKey('message') && body['message'] != null) {
            errorMessage = body['message'].toString();
          } else if (body.containsKey('non_field_errors') && body['non_field_errors'] is List && (body['non_field_errors'] as List).isNotEmpty) {
            errorMessage = (body['non_field_errors'] as List).first.toString();
          } else if (body.isNotEmpty) {
            // Try to get the first error message
            final firstEntry = body.entries.first;
            if (firstEntry.value is String) {
              errorMessage = firstEntry.value.toString();
            } else if (firstEntry.value is List && (firstEntry.value as List).isNotEmpty) {
              errorMessage = (firstEntry.value as List).first.toString();
            }
          }
        }
        
        return Left(Failure(statusCode: response.statusCode, message: errorMessage));
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
      } else if (response.statusCode != 200 && response.body != null) {
        // Handle error response with message from server
        String errorMessage = 'Failed to reset password';
        
        if (response.body is Map<String, dynamic>) {
          final body = response.body as Map<String, dynamic>;
          
          // Try to extract error message from common error fields
          if (body.containsKey('detail') && body['detail'] != null) {
            errorMessage = body['detail'].toString();
          } else if (body.containsKey('message') && body['message'] != null) {
            errorMessage = body['message'].toString();
          } else if (body.containsKey('non_field_errors') && body['non_field_errors'] is List && (body['non_field_errors'] as List).isNotEmpty) {
            errorMessage = (body['non_field_errors'] as List).first.toString();
          } else if (body.isNotEmpty) {
            // Try to get the first error message
            final firstEntry = body.entries.first;
            if (firstEntry.value is String) {
              errorMessage = firstEntry.value.toString();
            } else if (firstEntry.value is List && (firstEntry.value as List).isNotEmpty) {
              errorMessage = (firstEntry.value as List).first.toString();
            }
          }
        }
        
        return Left(Failure(statusCode: response.statusCode, message: errorMessage));
      }
      return Left(FailureServer());
    } catch (e) {
      log("error 🔥🔥🔥🔥🔥 Reset Password:::$e");
      return Left(Failure.handleError(e as Exception));
    }
  }

  //? -----------------------------------------------------------------
  //* getStudyYears
  @override
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getStudyYears);
      final ApiResponse response = await api.get(request);
      final List<StudyYearModel> studyYears = [];

      if (response.statusCode == 200) {
        final data = response.body;

        // 🟢 الحالة الأساسية: response.body = Map وفيه key اسمه "results"
        if (data is Map<String, dynamic> && data['results'] is List) {
          for (final item in data['results']) {
            studyYears.add(StudyYearModel.fromJson(item));
          }
        }
        // 🟡 حالة احتياط: لو رجع List مباشرة
        else if (data is List) {
          for (final item in data) {
            studyYears.add(StudyYearModel.fromJson(item));
          }
        }

        return Right(studyYears);
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
}
