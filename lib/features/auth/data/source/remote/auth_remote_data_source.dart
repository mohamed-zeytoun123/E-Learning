import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/model/response_model/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  //? ------------------------------------------------------------
  //* LogIn
  Future<Either<Failure, AuthResponseModel>> loginRemote(
    String numberPhone,
    String password,
  );

  //* SignUp
  Future<Either<Failure, AuthResponseModel>> signUpRemote({
    required String fullName,
    required int universityId,
    required int collegeId,
    required int studyYear,
    required String phone,
    required String password,
  });

  //? ------------------------------------------------------------
}
