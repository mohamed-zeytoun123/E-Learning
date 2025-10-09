import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/model/response_model/auth_response_model.dart';

abstract class AuthRepository {
  //? -------------------------------------------------------------------

  //* LogIn
  Future<Either<Failure, AuthResponseModel>> loginRepo(
    String numberPhone,
    String password,
  );

  //* Sign Up
  Future<Either<Failure, AuthResponseModel>> signUpRepo({
    required String fullName,
    required int universityId,
    required int collegeId,
    required int studyYear,
    required String phone,
    required String password,
  });
  //? -------------------------------------------------------------------
}
