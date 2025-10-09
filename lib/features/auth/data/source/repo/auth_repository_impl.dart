import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/core/model/response_model/auth_response_model.dart';
import 'package:e_learning/features/auth/data/source/local/auth_local_data_source.dart';
import 'package:e_learning/features/auth/data/source/remote/auth_remote_data_source.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;
  final NetworkInfoService network;

  AuthRepositoryImpl({
    required this.remote,
    required this.local,
    required this.network,
  });
  //? -----------------------------------------------------------------
  //* LogIn
  @override
  Future<Either<Failure, AuthResponseModel>> loginRepo(
    String numberPhone,
    String password,
  ) async {
    if (await network.isConnected) {
      final result = await remote.loginRemote(numberPhone, password);
      return result.fold((failure) => Left(failure), (userData) async {
        // await local.cachedUserData(userData);
        return Right(userData);
      });
    } else {
      return Left(FailureNoConnection());
    }
  }

  //? -----------------------------------------------------------------
  //* Sign UP
  @override
  Future<Either<Failure, AuthResponseModel>> signUpRepo({
    required String fullName,
    required int universityId,
    required int collegeId,
    required int studyYear,
    required String phone,
    required String password,
  }) async {
    if (await network.isConnected) {
      final result = await remote.signUpRemote(
        fullName: fullName,
        universityId: universityId,
        collegeId: collegeId,
        studyYear: studyYear,
        phone: phone,
        password: password,
      );
      return result.fold(
        (error) {
          return Left(error);
        },
        (userData) async {
          // await local.save(userData);

          return Right(userData);
        },
      );
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?----------------------------------------------------------

  //? -----------------------------------------------------------------
}
