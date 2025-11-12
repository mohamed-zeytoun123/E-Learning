import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/profile/data/model/data_course_saved_model.dart';
import 'package:e_learning/features/profile/data/model/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/model/user_data_info_model.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_dat_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemouteDataSource {
  final API api;

  ProfileRemoteDataSourceImpl({required this.api});

  //* fetch privacy policy remote data
  @override
  Future<Either<Failure, ResponseInfoAppModel>> getPrivacyPolicyinfo() async {
    // TODO: implement getPrivacyPolicyinfo
    try {
      var response = await api.get(ApiRequest(url: AppUrls.privacyPolicy));
      // print(response.bo)
      final data = ResponseInfoAppModel.fromMap(response.body);
      print('✅ privacy policy status code ${response.statusCode}');
      return right(data);
    } catch (error) {
      log("error 🔥🔥🔥🔥🔥 :::$error");
      return Left(Failure.handleError(error as DioException));
    }

    // throw UnimplementedError();
  }

  //*--------------------------     fetch About Us remote data     --------------------------------
  @override
  Future<Either<Failure, ResponseInfoAppModel>> getAboutUpInfo() async {
    // TODO: implement getAboutUpInfo
    try {
      var response = await api.get(ApiRequest(url: AppUrls.aboutUs));
      var data = ResponseInfoAppModel.fromMap(response.body);
      log(' ✅  about us Status Code : ${response.statusCode}');
      return right(data);
    } catch (error) {
      return left(Failure.handleError(error as DioException));
    }

    // throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ResponseInfoAppModel>> getTermsCondition() async {
    try {
      var response = await api.get(ApiRequest(url: AppUrls.termsConditions));
      var data = ResponseInfoAppModel.fromMap(response.body);
      return right(data);
    } catch (error) {
      log("error 🔥🔥🔥🔥🔥 :::$error");
      return left(Failure.handleError(error as DioException));
    }
  }

  @override
  Future<Either<Failure, UserDataInfoModel>> getDataUser() async {
    try {
      var response = await api.get(ApiRequest(url: AppUrls.profileUserInfo));
      var dataResponse = UserDataInfoModel.fromMap(response.body);
      return right(dataResponse);
    } catch (error) {
      log("error fetch data user 🔥🔥🔥🔥🔥 :::$error");
      return left(Failure.handleError(error as DioException));
    }
  }

  // -------------------------- fetch data save Courses---------------
  @override
  Future<Either<Failure, DataResponseSaveCoursesPagination>>
  getDataCoursesSaved() async {
    try {
      var response = await api.get(
        ApiRequest(url: '${AppUrls.saveCourses}?page=1&page_size=10'),
      );
      // var data =       DataCourseSaved.fromMap(response.body);
      // var data = (response.body as List).map((item) {
      //   return DataResponseSaveCoursesPagination.fromMap(item);
      // }).toList();
      var data = DataResponseSaveCoursesPagination.fromMap(
        response.body
      );
      log("👌✅ success fetch data course saved 🔥🔥🔥");
      return right(data);
    } catch (error) {
      log("error fetch data Course saved 🔥🔥🔥🔥🔥 :::$error");
      return left(Failure.handleError(error as DioException));
    }
  }
}
