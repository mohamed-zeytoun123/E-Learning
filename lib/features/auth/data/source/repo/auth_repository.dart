import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/core/model/auth_response_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/params/reset_password_request_params.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/response/otp_verification_response.dart';

abstract class AuthRepository {
  //? -------------------------------------------------------------------

  //* LogIn
  Future<Either<Failure, AuthResponseModel>> loginRepo(
    String numberPhone,
    String password,
  );

  //* Sign Up
  Future<Either<Failure, AuthResponseModel>> signUpRepo({
    required SignUpRequestParams params,
  });

  //* Get Universities
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRepo();

  //* Get Colleges by University
  Future<Either<Failure, List<CollegeModel>>> getCollegesRepo({
    required int universityId,
  });

  //* Get Study Years
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRepo();

  //* otp verfication
  Future<Either<Failure, OtpVerificationResponse>> otpVerficationRepo({
    required String phone,
    required String code,
    required String purpose, // reset_password || sign_up
  });

  //* Forget Password
  Future<Either<Failure, bool>> forgetPasswordRepo({required String phone});

  //* Reset Password
  Future<Either<Failure, bool>> resetPasswordRepo({
    required ResetPasswordRequestParams params,
  });
  //* logout student
  Future<Either<Failure, bool>> logOutRepo(String refreshToken);
  //? -------------------------------------------------------------------
}
