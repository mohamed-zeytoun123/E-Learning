import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/profile/data/models/data_college_model.dart';
import 'package:e_learning/features/profile/data/models/data_course_saved_model.dart';
import 'package:e_learning/features/profile/data/models/data_univarcity_response_model.dart';
import 'package:e_learning/features/profile/data/models/data_year_response_model.dart';
import 'package:e_learning/features/profile/data/models/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/models/user_data_info_model.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_dat_source.dart';

class ProfileRepository {
  final ProfileRemouteDataSource remote;
  final NetworkInfoService network;

  ProfileRepository({required this.remote, required this.network});

  Future<Either<Failure, ResponseInfoAppModel>> getPrivacyPolicyRepo() async {
    if (await network.isConnected) {
      final result = await remote.getPrivacyPolicyinfo();
      return result.fold(
        (error) {
          return left(error);
        },
        (dataResponse) {
          return right(dataResponse);
        },
      );
    } else {
      return left(Failure(message: 'No internet connection'));
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
      return left(Failure(message: 'No internet connection'));
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
      return left(Failure(message: 'No internet connection'));
    }
  }

  Future<Either<Failure, UserDataInfoModel>> getDataUserProfileRepo() async {
    if (await network.isConnected) {
      var result = await remote.getDataUser();
      return result.fold(
        (error) {
          return left(error);
        },
        (data) {
          return right(data);
        },
      );
    } else {
      return left(Failure(message: 'No internet connection'));
    }
  }

  Future<Either<Failure, DataResponseSaveCoursesPagination>>
      getDataSavedCoursesRepo() async {
    if (await network.isConnected) {
      var result = await remote.getDataCoursesSaved();
      return result.fold(
        (error) {
          return left(error);
        },
        (data) {
          return right(data);
        },
      );
    } else {
      return left(Failure(message: 'No internet connection'));
    }
  }

  Future<Either<Failure, UserDataInfoModel>> EditDataProfileStudent(
      String phone, String name,int universityId,int collegeId,int studyYearId) async {
    if (await network.isConnected) {
      var result = await remote.editDataProfileStudent(phone, name,universityId,collegeId,studyYearId);
      return result.fold((error) {
        return left(error);
      }, (dataResponse) {
        return right(dataResponse);
      });
    } else {
      return left(Failure(message: 'No internet connection'));
    }
  }

  Future<Either<Failure, DataResonseunivarsity>> getDataUnivarcityRepo() async {
    if (await network.isConnected) {
      var result = await remote.getDataUnivarcity();
      return result.fold(
        (error) {
          return left(error);
        },
        (data) {
          return right(data);
        },
      );
    } else {
      return left(Failure(message: 'No internet connection'));
    }
  }

  Future<Either<Failure, DataResonseCollege>> getCollegeDataRepo(
      int idUnivarcity) async {
    if (await network.isConnected) {
      var result = await remote.getCollegeData(idUnivarcity);
      return result.fold(
        (error) {
          return left(error);
        },
        (data) {
          return right(data);
        },
      );
    } else {
      return left(Failure(message: 'No internet connection'));
    }
  }

  Future<Either<Failure, DataResonseYearStudent>> getYearDataStudentRepo() async {
    if (await network.isConnected) {
      var result = await remote.getYearDataStudent();
      return result.fold(
        (error) {
          return left(error);
        },
        (data) {
          return right(data);
        },
      );
    } else {
      return left(Failure(message: 'No internet connection'));
    }
  }
}
