import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/model/enums/app_role_enum.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/core/model/response_model/auth_response_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/params/reset_password_request_params.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/auth/data/models/response/otp_verification_response.dart';
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
        await local.saveAllTokensLocal(
          accessToken: userData.access,
          refreshToken: userData.refresh,
        );

        if (userData.role.isNotEmpty) {
          final firstChar = userData.role[0].toLowerCase();
          AppRoleEnum roleEnum;

          switch (firstChar) {
            case 'S':
              roleEnum = AppRoleEnum.student;
              break;
            case 'T':
              roleEnum = AppRoleEnum.teacher;
              break;
            case 'U':
              roleEnum = AppRoleEnum.user;
              break;
            default:
              roleEnum = AppRoleEnum.user;
          }

          await local.saveRoleLocal(roleEnum);
        }

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
    required SignUpRequestParams params,
  }) async {
    if (await network.isConnected) {
      final result = await remote.signUpRemote(params: params);
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

  //? -----------------------------------------------------------------

  //* Get Universities
  @override
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRepo() async {
    if (await network.isConnected) {
      final result = await remote.getUniversitiesRemote();

      return result.fold((failure) => Left(failure), (universities) {
        if (universities.isNotEmpty) {
          return Right(universities);
        } else {
          return Left(FailureNoData());
        }
      });
    } else {
      return Left(FailureNoConnection());
    }
  }

  //? -----------------------------------------------------------------
  //* Get Colleges by University
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRepo({
    required int universityId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getCollegesRemote(universityId: universityId);

      return result.fold((failure) => Left(failure), (colleges) {
        if (colleges.isNotEmpty) {
          return Right(colleges);
        } else {
          return Left(FailureNoData());
        }
      });
    } else {
      return Left(FailureNoConnection());
    }
  }

  //* otp Verfication
  @override
  Future<Either<Failure, OtpVerificationResponse>> otpVerficationRepo({
    required String phone,
    required String code,
    required String purpose, // reset_password || sign_up
  }) async {
    if (await network.isConnected) {
      final result = await remote.otpVerficationRemote(
        phone: phone,
        code: code,
        purpose: purpose,
      );
      return result.fold(
        (error) {
          return Left(error);
        },
        (response) async {
          return Right(response);
        },
      );
    } else {
      return Left(FailureNoConnection());
    }
  }

  //* Forget Password
  @override
  Future<Either<Failure, bool>> forgetPasswordRepo({
    required String phone,
  }) async {
    if (await network.isConnected) {
      final result = await remote.forgetPasswordRemote(phone: phone);
      return result.fold(
        (error) {
          return Left(error);
        },
        (isSent) async {
          return Right(isSent);
        },
      );
    } else {
      return Left(FailureNoConnection());
    }
  }

  //* Reset Password
  @override
  Future<Either<Failure, bool>> resetPasswordRepo({
    required ResetPasswordRequestParams params,
  }) async {
    if (await network.isConnected) {
      final result = await remote.resetPasswordRemote(params: params);
      return result.fold(
        (error) {
          return Left(error);
        },
        (isReset) async {
          return Right(isReset);
        },
      );
    } else {
      return Left(FailureNoConnection());
    }
  }

  // @override
  // Future<Either<Failure, bool>> logOutRepo(String refreshToken) async {
  //   if (await network.isConnected) {
  //     var result = await remote.logOutRemote(refreshToken);
  //     return result.fold(
  //       (error) {
  //         return left(error);
  //       },
  //       (data) {
  //         return right(data);
  //       },
  //     );
  //   } else {
  //     return left(FailureNoConnection());
  //   }
  // }

  //? -----------------------------------------------------------------
}
