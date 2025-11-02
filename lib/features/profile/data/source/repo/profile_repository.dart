import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/profile/data/model/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_dat_source.dart';

class ProfileRepository {
  final ProfileRemouteDataSource remote;
  final NetworkInfoService network;

  ProfileRepository({required this.remote, required this.network});

  Future<Either<Failure, ResponseInfoAppModel>> getPrivacyPolicyRepo() async {
    if (await network.isConnected) {
      final result = await remote.getPrivacyPolicyinfo();
      //  print('hala');
      return result.fold(
        (error) {
          return left(error);
        },
        (dataResponse) {
          log('success');
          return right(dataResponse);
        },
      );
    } else {
      log(' error connected network (privacy policy)');
      return left(FailureNoConnection());
    }
  }

  Future<Either<Failure, ResponseInfoAppModel>> getAboutUsRepo() async {
    if (await network.isConnected) {
      final result = await remote.getAboutUpInfo();
      return result.fold(
        (error) {
          return left(error);
        },
        (dataResponse) {
          return right(dataResponse);
        },
      );
    } else {
      return left(FailureNoConnection());
    }
    //  var response =await
  }

  Future<Either<Failure, ResponseInfoAppModel>> getTermsConditionsData() async {
    if (await network.isConnected) {
      var result = await remote.getTermsCondition();
      return result.fold(
        (error) {
          return left(error);
        },
        (data) {
          return right(data);
        },
      );
    } else {
      log("error , no connected  🔥🔥🔥🔥🔥 ");
      return left(FailureNoConnection());
    }
  }
}


//  @override
//   Future<Either<Failure, AuthResponseModel>> signUpRepo({
//     required SignUpRequestParams params,
//   }) async {
//     if (await network.isConnected) {
//       final result = await remote.signUpRemote(params: params);
//       return result.fold(
//         (error) {
//           return Left(error);
//         },
//         (userData) async {
//           // await local.save(userData);

//           return Right(userData);
//         },
//       );
//     } else {
//       return Left(FailureNoConnection());
//     }
//   }