import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:network/failures/failures.dart';
import 'package:network/network.dart';
import 'package:network/network/api/api_request.dart';
import 'package:e_learning/core/model/paginated_model.dart';
import 'package:e_learning/features/profile/data/models/data_college_model.dart';
import 'package:e_learning/features/profile/data/models/data_course_saved_model.dart';
import 'package:e_learning/features/profile/data/models/data_univarcity_response_model.dart';
import 'package:e_learning/features/profile/data/models/data_year_response_model.dart';
import 'package:e_learning/features/profile/data/models/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/models/user_data_info_model.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_dat_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemouteDataSource {
  final API api;

  ProfileRemoteDataSourceImpl({required this.api});

  //* fetch privacy policy remote data
  @override
  Future<Either<Failure, ResponseInfoAppModel>> getPrivacyPolicyinfo() async {
    try {
      var response = await api.get(ApiRequest(
        url: AppUrls.privacyPolicy,
        headers: ApiRequestParameters.authHeaders,
      ));
      final body = response.body;
      if (body is Map<String, dynamic>) {
        final data = ResponseInfoAppModel.fromMap(body);
        return right(data);
      }
      return Left(Failure(message: 'Invalid response format'));
    } catch (error) {
      if (error is DioException) {
        return Left(Failure.fromException(error));
      }
      return Left(Failure(message: error.toString()));
    }
  }

  //*--------------------------     fetch About Us remote data     --------------------------------
  @override
  Future<Either<Failure, ResponseInfoAppModel>> getAboutUpInfo() async {
    try {
      var response = await api.get(ApiRequest(
        url: AppUrls.aboutUs,
        headers: ApiRequestParameters.authHeaders,
      ));
      final body = response.body;
      if (body is Map<String, dynamic>) {
        var data = ResponseInfoAppModel.fromMap(body);
        return right(data);
      }
      return Left(Failure(message: 'Invalid response format'));
    } catch (error) {
      if (error is DioException) {
        return left(Failure.fromException(error));
      }
      return left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseInfoAppModel>> getTermsCondition() async {
    try {
      var response = await api.get(ApiRequest(
        url: AppUrls.termsConditions,
        headers: ApiRequestParameters.authHeaders,
      ));
      final body = response.body;
      if (body is Map<String, dynamic>) {
        var data = ResponseInfoAppModel.fromMap(body);
        return right(data);
      }
      return Left(Failure(message: 'Invalid response format'));
    } catch (error) {
      if (error is DioException) {
        return left(Failure.fromException(error));
      }
      return left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDataInfoModel>> getDataUser() async {
    try {
      var response = await api.get(ApiRequest(
        url: AppUrls.profileUserInfo,
        headers: ApiRequestParameters.authHeaders,
      ));
      final body = response.body;
      if (body is Map<String, dynamic>) {
        var dataResponse = UserDataInfoModel.fromMap(body);
        return right(dataResponse);
      }
      return Left(Failure(message: 'Invalid response format'));
    } catch (error) {
      if (error is DioException) {
        return left(Failure.fromException(error));
      }
      return left(Failure(message: error.toString()));
    }
  }

  // -------------------------- fetch data save Courses---------------
  @override
  Future<Either<Failure, DataResponseSaveCoursesPagination>>
      getDataCoursesSaved() async {
    try {
      var response = await api.get(
        ApiRequest(
          url: '${AppUrls.saveCourses}?page=1&page_size=10',
          headers: ApiRequestParameters.authHeaders,
        ),
      );
      final body = response.body;
      if (body is Map<String, dynamic>) {
        var data = PaginationModel<DataCourseSaved>.fromJson(body, (json) => DataCourseSaved.fromJson(json as Map<String, dynamic>));
        return right(data);
      }
      return Left(Failure(message: 'Invalid response format'));
    } catch (error) {
      if (error is DioException) {
        return left(Failure.fromException(error));
      }
      return left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDataInfoModel>> editDataProfileStudent(
      String phone,
      String name,
      int universityId,
      int collegeId,
      int studyYearId) async {
    try {
      var response = await api.put(ApiRequest(
        url: AppUrls.profileUserInfo,
        body: {
          'full_name': name,
          'phone': phone,
          'university_id': universityId,
          'college_id': collegeId,
          'study_year_id': studyYearId,
        },
        headers: ApiRequestParameters.authHeaders,
      ));
      final body = response.body;
      if (body is Map<String, dynamic>) {
        var data = UserDataInfoModel.fromMap(body);
        return right(data);
      }
      return Left(Failure(message: 'Invalid response format'));
    } catch (error) {
      if (error is DioException) {
        return left(Failure.fromException(error));
      }
      return left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, DataResonseunivarsity>> getDataUnivarcity() async {
    try {
      var response = await api.get(ApiRequest(
        url: AppUrls.getUniversities,
        headers: ApiRequestParameters.authHeaders,
      ));
      final body = response.body;
      if (body is Map<String, dynamic>) {
        var data = PaginationModel<UniData>.fromJson(body, (json) => UniData.fromJson(json as Map<String, dynamic>));
        return right(data);
      }
      return Left(Failure(message: 'Invalid response format'));
    } catch (error) {
      if (error is DioException) {
        return left(Failure.fromException(error));
      }
      return left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, DataResonseCollege>> getCollegeData(
      int idUnivarcity) async {
    try {
      var response = await api.get(ApiRequest(
        url: '${AppUrls.getColleges}?university=$idUnivarcity',
        headers: ApiRequestParameters.authHeaders,
      ));
      final body = response.body;
      if (body is Map<String, dynamic>) {
        var data = PaginationModel<College>.fromJson(body, (json) => College.fromJson(json as Map<String, dynamic>));
        return right(data);
      }
      return Left(Failure(message: 'Invalid response format'));
    } catch (error) {
      if (error is DioException) {
        return left(Failure.fromException(error));
      }
      return left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, DataResonseYearStudent>> getYearDataStudent() async {
    try {
      var response = await api.get(ApiRequest(
        url: AppUrls.getStudyYears,
        headers: ApiRequestParameters.authHeaders,
      ));
      final body = response.body;
      if (body is Map<String, dynamic>) {
        var data = PaginationModel<YearDataModel>.fromJson(body, (json) => YearDataModel.fromJson(json as Map<String, dynamic>));
        return right(data);
      }
      return Left(Failure(message: 'Invalid response format'));
    } catch (error) {
      if (error is DioException) {
        return left(Failure.fromException(error));
      }
      return left(Failure(message: error.toString()));
    }
  }
}
