import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/profile/data/model/data_college_model.dart';
import 'package:e_learning/features/profile/data/model/data_course_saved_model.dart';
import 'package:e_learning/features/profile/data/model/data_univarcity_response_model.dart';
import 'package:e_learning/features/profile/data/model/data_year_response_model.dart';
import 'package:e_learning/features/profile/data/model/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/model/user_data_info_model.dart';
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

  Future<Either<Failure, UserDataInfoModel>> getDataUserProfileRepo() async {
    if (await network.isConnected) {
      var result = await remote.getDataUser();
      return result.fold(
        (error) {
          return left(error);
        },
        (data) {
          log(" ✅👌 success  ,get data user from remote  ");
          return right(data);
        },
      );
    } else {
      log("error , no connected  🔥🔥🔥🔥🔥 ");
      return left(FailureNoConnection());
    }
  }

  Future<Either<Failure, DataResponseSaveCoursesPagination>>
      getDataSavedCoursesRepo(int page) async {
    if (await network.isConnected) {
      var result = await remote.getDataCoursesSaved(page);
      return result.fold(
        (error) {
          log(
            ' error fetch data save course 🔥🔥🔥🔥🔥 ',
          );
          return left(error);
        },
        (data) {
          log(" ✅👌 success  ,get data save course from remote  ");
          return right(data);
        },
      );
    } else {
      return left(FailureNoConnection());
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
      return left(FailureNoConnection());
    }
  }

  Future<Either<Failure, DataResonseunivarsity>> getDataUnivarcityRepo() async {
    if (await network.isConnected) {
      var result = await remote.getDataUnivarcity();
      return result.fold(
        (error) {
          log(
            ' error fetch data univarcity 🔥🔥🔥🔥🔥 ',
          );
          return left(error);
        },
        (data) {
          log(" ✅👌 success  ,get data univarcity from remote  ");
          return right(data);
        },
      );
    } else {
      return left(FailureNoConnection());
    }
  }

  Future<Either<Failure, DataResonseCollege>> getCollegeDataRepo(
      int idUnivarcity) async {
    if (await network.isConnected) {
      var result = await remote.getCollegeData(idUnivarcity);
      return result.fold(
        (error) {
          log(
            ' error fetch data college 🔥🔥🔥🔥🔥 ',
          );
          return left(error);
        },
        (data) {
          log(" ✅👌 success  ,get data college from remote  ");
          return right(data);
        },
      );
    } else {
      return left(FailureNoConnection());
    }
  }

  Future<Either<Failure, DataResonseYearStudent>> getYearDataStudentRepo() async {
    if (await network.isConnected) {
      var result = await remote.getYearDataStudent();
      return result.fold(
        (error) {
          log(
            ' error fetch data year student 🔥🔥🔥🔥🔥 ',
          );
          return left(error);
        },
        (data) {
          log(" ✅👌 success  ,get data year student from remote  ");
          return right(data);
        },
      );
    } else {
      return left(FailureNoConnection());
    }
  }
}
