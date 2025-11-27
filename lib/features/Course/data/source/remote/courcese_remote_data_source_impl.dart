import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:network/failures/failures.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/paginated_courses_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/enroll/channel_model.dart';
import 'package:e_learning/features/Course/data/models/enrollment_model.dart';
import 'package:e_learning/features/Course/data/models/rating_result/paginated_ratings_model.dart';
import 'package:e_learning/features/Course/data/models/rating_result/rating_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/paginated_chapters_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';
import 'package:e_learning/features/Course/data/source/remote/courcese_remote_data_source.dart';

class CourceseRemoteDataSourceImpl implements CourceseRemoteDataSource {
  final API api;

  CourceseRemoteDataSourceImpl({required this.api});

  // ----------------------------------------------------
  // Get Categories
  @override
  Future<Either<Failure, List<CategorieModel>>> getCategoriesRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getCategories);
      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        final results = (data is Map<String, dynamic>)
            ? data['results']
            : null;

        final List<CategorieModel> categories = [];

        if (results is List) {
          for (var item in results) {
            if (item is Map<String, dynamic>) {
              categories.add(CategorieModel.fromMap(item));
            }
          }
        }

        return Right(categories);
      }

      return Left(Failure(
        message: response.body?['message']?.toString() ?? "Unknown error",
        statusCode: response.statusCode,
      ));
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Get Courses
  @override
  Future<Either<Failure, PaginatedCoursesModel>> getCoursesRemote({
    CourseFiltersModel? filters,
    int? page,
    int? pageSize,
    String? ordering,
    String? search,
  }) async {
    try {
      final queryParameters = {
        if (filters?.collegeId != null) 'college': filters!.collegeId.toString(),
        if (filters?.studyYear != null) 'study_year': filters!.studyYear.toString(),
        if (filters?.categoryId != null) 'category': filters!.categoryId.toString(),
        if (search != null && search.isNotEmpty) 'search': search,
        if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getCourses(queryParameters: queryParameters),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200 &&
          response.body is Map<String, dynamic>) {
        return Right(
          PaginatedCoursesModel.fromMap(response.body as Map<String, dynamic>),
        );
      }

      return Left(Failure(
        message: "Invalid data format from server",
      ));
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Get Colleges
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getColleges);
      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;
        final results = (data is Map<String, dynamic>) ? data['results'] : null;

        final List<CollegeModel> colleges = [];

        if (results is List) {
          for (var item in results) {
            if (item is Map<String, dynamic>) {
              colleges.add(CollegeModel.fromMap(item));
            }
          }
        }

        return Right(colleges);
      }

      return Left(Failure(
        message: response.body?['message']?.toString() ?? "Unknown error",
        statusCode: response.statusCode,
      ));
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Course Details
  @override
  Future<Either<Failure, CourseDetailsModel>> getCourseDetailsRemote({
    required String courseSlug,
  }) async {
    try {
      final ApiRequest request =
          ApiRequest(url: AppUrls.courseDetails(courseSlug));

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200 &&
          response.body is Map<String, dynamic>) {
        return Right(
          CourseDetailsModel.fromMap(response.body as Map<String, dynamic>),
        );
      }

      return Left(FailureServer());
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Chapters
  @override
  Future<Either<Failure, PaginatedChaptersModel>> getChaptersRemote({
    required String courseId,
    int? page,
    int? pageSize,
  }) async {
    try {
      final queryParameters = {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getChapters(courseId, queryParameters: queryParameters),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200 &&
          response.body is Map<String, dynamic>) {
        return Right(
          PaginatedChaptersModel.fromMap(response.body as Map<String, dynamic>),
        );
      }

      return Left(Failure(message: "Invalid data format from server"));
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Ratings
  @override
  Future<Either<Failure, PaginatedRatingsModel>> getRatingsRemote({
    required String courseId,
    int? page,
    int? pageSize,
    String? ordering,
  }) async {
    try {
      final queryParameters = {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
        if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getRatings(courseId, queryParameters: queryParameters),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200 &&
          response.body is Map<String, dynamic>) {
        return Right(
          PaginatedRatingsModel.fromJson(response.body as Map<String, dynamic>),
        );
      }

      return Left(Failure(message: "Invalid data format from server"));
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Universities
  @override
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getUniversities);
      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;
        final results = (data is Map<String, dynamic>)
            ? data['results']
            : (data is List ? data : null);

        final List<UniversityModel> universities = [];

        if (results is List) {
          for (var item in results) {
            if (item is Map<String, dynamic>) {
              universities.add(UniversityModel.fromMap(item));
            }
          }
        }

        return Right(universities);
      }

      return Left(Failure(
        message: response.body?['message']?.toString() ?? "Unknown error",
        statusCode: response.statusCode,
      ));
    } catch (e) {
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Favorite Toggle
  @override
  Future<Either<Failure, bool>> toggleFavoriteCourseRemote({
    required String courseSlug,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.favoriteCourse(courseSlug),
      );

      final ApiResponse response = await api.post(request);

      if (response.statusCode == 200 &&
          response.body is Map<String, dynamic>) {
        return Right(response.body?['is_favorite'] ?? false);
      }

      return Left(Failure(message: "Invalid data format from server"));
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Study Years
  @override
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getStudyYears);
      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final results = (response.body is Map<String, dynamic>)
            ? (response.body?['results'])
            : null;

        final List<StudyYearModel> studyYears = [];

        if (results is List) {
          for (var item in results) {
            if (item is Map<String, dynamic>) {
              studyYears.add(StudyYearModel.fromMap(item));
            }
          }
        }

        return Right(studyYears);
      }

      return Left(
        Failure(
          message: response.body?['message']?.toString() ?? "Unknown error",
          statusCode: response.statusCode,
        ),
      );
    } catch (e) {
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Add Rating
  @override
  Future<Either<Failure, RatingModel>> addRatingRemote({
    required int rating,
    required String courseId,
    String? comment,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.addRating(courseId),
        body: {
          'rating': rating,
          if (comment != null && comment.isNotEmpty) 'comment': comment,
        },
      );

      final ApiResponse response = await api.post(request);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.body is Map<String, dynamic>) {
        return Right(
          RatingModel.fromJson(response.body as Map<String, dynamic>),
        );
      }

      return Left(Failure(message: "Invalid data format from server"));
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Enroll Course
  @override
  Future<Either<Failure, EnrollmentModel>> enrollCourseRemote({
    required int courseId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.enrollCourse,
        body: {'course_id': courseId},
      );

      final ApiResponse response = await api.post(request);

      if (response.statusCode == 201 &&
          response.body is Map<String, dynamic>) {
        final enrollment = response.body?['enrollment'];
        if (enrollment is Map<String, dynamic>) {
          return Right(EnrollmentModel.fromJson(enrollment));
        }
      }

      return Left(Failure(message: "Invalid data format from server"));
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }

  // ----------------------------------------------------
  // Channels
  @override
  Future<Either<Failure, List<ChannelModel>>> getChannelsRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getChannels);
      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200 &&
          response.body is Map<String, dynamic>) {
        final results = response.body?['results'] ?? [];
        final List<ChannelModel> channels = [];

        if (results is List) {
          for (var item in results) {
            if (item is Map<String, dynamic>) {
              channels.add(ChannelModel.fromMap(item));
            }
          }
        }

        return Right(channels);
      }

      return Left(Failure(
        message: response.body?['message']?.toString() ?? "Unknown error",
        statusCode: response.statusCode,
      ));
    } catch (e) {
      log(e.toString());
      return Left(Failure.handleError(e as DioException));
    }
  }
}
