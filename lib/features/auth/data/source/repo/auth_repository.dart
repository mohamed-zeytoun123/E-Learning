import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/model/response_model/auth_response_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';

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

  //* otp verfication
  Future<Either<Failure, bool>> otpVerficationRepo({
    required String phone,
    required String code,
    required String purpose, // reset_password || sign_up
  });

  //* Forget Password
  Future<Either<Failure, bool>> forgetPasswordRepo({required String phone});

  //? -------------------------------------------------------------------
}
