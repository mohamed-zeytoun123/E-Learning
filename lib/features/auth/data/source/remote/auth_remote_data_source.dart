import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/model/response_model/auth_response_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';

abstract class AuthRemoteDataSource {
  //? ------------------------------------------------------------
  //* LogIn
  Future<Either<Failure, AuthResponseModel>> loginRemote(
    String numberPhone,
    String password,
  );

  //* SignUp
  Future<Either<Failure, AuthResponseModel>> signUpRemote({
    required SignUpRequestParams params,
  });

  //* getUniversities
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRemote();

  //* getColleges
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote({
    required int universityId,
  });

  //* Otp Verfication
  Future<Either<Failure, bool>> otpVerficationRemote({
    required String phone,
    required String code,
    required String purpuse, // reset_password || sign_up
  });

  //* Forget Password
  Future<Either<Failure, bool>> forgetPasswordRemote({required String phone});

  //? ------------------------------------------------------------
}
