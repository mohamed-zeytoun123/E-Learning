import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/features/profile/data/model/data_college_model.dart';
import 'package:e_learning/features/profile/data/model/data_course_saved_model.dart';
import 'package:e_learning/features/profile/data/model/data_univarcity_response_model.dart';
import 'package:e_learning/features/profile/data/model/data_year_response_model.dart';
import 'package:e_learning/features/profile/data/model/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/model/user_data_info_model.dart';

abstract class ProfileRemouteDataSource {
  Future<Either<Failure, ResponseInfoAppModel>> getPrivacyPolicyinfo();
  Future<Either<Failure, ResponseInfoAppModel>> getAboutUpInfo();
  Future<Either<Failure, ResponseInfoAppModel>> getTermsCondition();
  Future<Either<Failure, UserDataInfoModel>> getDataUser();
  Future<Either<Failure, DataResponseSaveCoursesPagination>>getDataCoursesSaved(int page);
  Future<Either<Failure, UserDataInfoModel>> editDataProfileStudent(String phone,String name,int universityId,int collegeId,int studyYearId);
  Future<Either<Failure,DataResonseunivarsity>> getDataUnivarcity();
  Future<Either<Failure,DataResonseCollege>> getCollegeData(int idUnivarcity);
  Future<Either<Failure,DataResonseYearStudent>> getYearDataStudent();
}
