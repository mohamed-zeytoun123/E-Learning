import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/course/data/models/course_details_model.dart';
import 'package:e_learning/features/course/data/models/course_model/course_model.dart';
import 'package:e_learning/features/course/data/source/remote/courcese_remote_data_source.dart';

class CourceseRemoteDataSourceImpl implements CourceseRemoteDataSource {
  final API api;

  CourceseRemoteDataSourceImpl({required this.api});

  //?----------------------------------------------------
  //* Get Filter Categories

  @override
  Future<Either<Failure, List<CategorieModel>>>
  getFilterCategoriesRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getCategories);

      final ApiResponse response = await api.get(request);
      final List<CategorieModel> categories = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List) {
          for (var item in data) {
            categories.add(CategorieModel.fromMap(item));
          }
        }

        return Right(categories);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?----------------------------------------------------
  //* Get Courses
  @override
  Future<Either<Failure, List<CourseModel>>> getCoursesRemote({
    int? collegeId,
    int? studyYear,
    int? categoryId,
    int? teacherId,
    String? search,
    String? ordering,
  }) async {
    try {
      //* تجهيز query parameters حسب القيم المرسلة
      final Map<String, dynamic> queryParameters = {
        if (collegeId != null) 'college': collegeId.toString(),
        if (studyYear != null) 'study_year': studyYear.toString(),
        if (categoryId != null) 'category': categoryId.toString(),
        if (teacherId != null) 'teacher': teacherId.toString(),
        if (search != null && search.isNotEmpty) 'search': search,
        if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getCourses,
        queryParameters: queryParameters,
      );

      final ApiResponse response = await api.get(request);
      final List<CourseModel> courses = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List) {
          for (var item in data) {
            courses.add(CourseModel.fromMap(item));
          }
        }

        return Right(courses);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?----------------------------------------------------
  //* Get Colleges
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getColleges);

      final ApiResponse response = await api.get(request);
      final List<CollegeModel> colleges = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List) {
          for (var item in data) {
            colleges.add(CollegeModel.fromMap(item));
          }
        }

        return Right(colleges);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?----------------------------------------------------

  //* Get Course Details by Slug
  @override
  Future<Either<Failure, CourseDetailsModel>> getCourseDetailsRemote({
    required String courseSlug,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.courseDetails(courseSlug),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final courseDetails = CourseDetailsModel.fromMap(data);
          return Right(courseDetails);
        } else {
          return Left(FailureServer());
        }
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?----------------------------------------------------
  
  //* Get Chapters by Course
  Future<Either<Failure, List<ChapterModel>>> getChaptersRemote({
    required int courseId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getChapters(courseId));

      final ApiResponse response = await api.get(request);
      final List<ChapterModel> chapters = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List) {
          for (var item in data) {
            chapters.add(ChapterModel.fromJson(item));
          }
        }

        return Right(chapters);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }
}
