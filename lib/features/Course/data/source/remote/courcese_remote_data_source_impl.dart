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
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';
import 'package:e_learning/features/Course/data/models/course_model/course_model.dart';
import 'package:e_learning/features/Course/data/source/remote/courcese_remote_data_source.dart';

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
        'ordering': (ordering != null && ordering.isNotEmpty)
            ? ordering
            : '-created_at', // Default ordering when not specified
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getCourses,
        queryParameters: queryParameters,
      );

      log('🌐 Request URL: ${AppUrls.getCourses}');
      log('🌐 Query Parameters: $queryParameters');

      final ApiResponse response = await api.get(request);
      final List<CourseModel> courses = [];

      log('📡 Courses API Response Status: ${response.statusCode}');
      log('📡 Response body type: ${response.body.runtimeType}');
      log('📡 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = response.body;

        // Handle paginated response (common in Django REST Framework)
        if (data is Map<String, dynamic>) {
          log('📡 Response is Map with keys: ${data.keys.toList()}');

          if (data.containsKey('results')) {
            final results = data['results'] as List?;
            log('📡 Results list length: ${results?.length ?? 0}');
            if (results != null && results.isNotEmpty) {
              for (var item in results) {
                try {
                  if (item is Map<String, dynamic>) {
                    courses.add(CourseModel.fromMap(item));
                  } else {
                    log('⚠️ Item is not Map: ${item.runtimeType}');
                  }
                } catch (e) {
                  log('❌ Error parsing course item: $e');
                  log('❌ Item data: $item');
                }
              }
            }
          } else {
            // Maybe the data itself is the list (like {"data": [...]})
            log('📡 No "results" key found. Checking for other keys...');
            // Check if there's a "data" key
            if (data.containsKey('data') && data['data'] is List) {
              final results = data['data'] as List;
              log('📡 Found "data" key with ${results.length} items');
              for (var item in results) {
                try {
                  if (item is Map<String, dynamic>) {
                    courses.add(CourseModel.fromMap(item));
                  }
                } catch (e) {
                  log('❌ Error parsing course item: $e');
                }
              }
            } else {
              // Try to parse the entire map as a single course (unlikely but handle it)
              log('⚠️ Unexpected map structure, attempting direct parse...');
            }
          }
        } else if (data is List) {
          log('📡 Response is direct List with ${data.length} items');
          // Handle direct list response
          for (var item in data) {
            try {
              if (item is Map<String, dynamic>) {
                courses.add(CourseModel.fromMap(item));
              } else {
                log('⚠️ List item is not Map: ${item.runtimeType}');
              }
            } catch (e) {
              log('❌ Error parsing course item: $e');
              log('❌ Item data: $item');
            }
          }
        } else {
          log('❌ Unexpected response format: ${data.runtimeType}');
          log('❌ Response data: $data');
          return Left(
            Failure(
              message: 'Unexpected response format: ${data.runtimeType}',
              statusCode: response.statusCode,
            ),
          );
        }

        log('✅ Successfully parsed ${courses.length} courses');
        return Right(courses);
      } else {
        String errorMessage = 'Unknown error';
        if (response.body is Map<String, dynamic>) {
          errorMessage =
              response.body['message']?.toString() ?? 'Unknown error';
        }
        return Left(
          Failure(
            message: errorMessage,
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
