import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/features/profile/data/model/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/model/user_data_info_model.dart';

abstract class ProfileRemouteDataSource {
  Future<Either<Failure, ResponseInfoAppModel>> getPrivacyPolicyinfo();
  Future<Either<Failure, ResponseInfoAppModel>> getAboutUpInfo();
  Future<Either<Failure, ResponseInfoAppModel>> getTermsCondition();
  Future<Either<Failure, UserDataInfoModel>> getDataUser();
}
