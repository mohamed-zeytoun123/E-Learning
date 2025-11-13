import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/paginated_courses_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/rating_model.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/paginated_chapters_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';
import 'package:e_learning/features/Course/data/source/remote/courcese_remote_data_source.dart';

class CourceseRemoteDataSourceImpl implements CourceseRemoteDataSource {
  final API api;

  CourceseRemoteDataSourceImpl({required this.api});

  //?----------------------------------------------------
  //* Get Categories

  @override
  Future<Either<Failure, List<CategorieModel>>> getCategoriesRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getCategories);

      final ApiResponse response = await api.get(request);
      final List<CategorieModel> categories = [];

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is Map && data['results'] is List) {
          for (var item in data['results']) {
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
  Future<Either<Failure, PaginatedCoursesModel>> getCoursesRemote({
    CourseFiltersModel? filters,
    int? page,
    int? pageSize,
    String? ordering,
    String? search,
  }) async {
    try {
      log(
        'Applying filters Remote : college=${filters?.collegeId}, studyYear=${filters?.studyYear}, category=${filters?.categoryId}, page=$page, page_size=$pageSize',
      );

      //* تجهيز query parameters حسب القيم المرسلة
      final Map<String, dynamic> queryParameters = {
        if (filters?.collegeId != null)
          'college': filters!.collegeId.toString(),
        if (filters?.studyYear != null)
          'study_year': filters!.studyYear.toString(),
        if (filters?.categoryId != null)
          'category': filters!.categoryId.toString(),
        if (search != null && search.isNotEmpty) 'search': search,
        if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getCourses(queryParameters: queryParameters),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final paginatedCourses = PaginatedCoursesModel.fromMap(data);
          return Right(paginatedCourses);
        } else {
          return Left(Failure(message: 'Invalid data format from server'));
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
  //* Get Colleges
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getColleges);

      final ApiResponse response = await api.get(request);
      final List<CollegeModel> colleges = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map && data['results'] is List) {
          for (var item in data['results']) {
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

  //* Get Chapters by Course (With Pagination)
  @override
  Future<Either<Failure, PaginatedChaptersModel>> getChaptersRemote({
    required String courseSlug,
    int? page,
    int? pageSize,
  }) async {
    try {
      log(
        'Fetching chapters for course=$courseSlug, page=$page, page_size=$pageSize',
      );

      // تجهيز query parameters
      final Map<String, dynamic> queryParameters = {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getChapters(courseSlug, queryParameters: queryParameters),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data['results'] is List) {
          final paginatedChapters = PaginatedChaptersModel.fromMap(data);
          return Right(paginatedChapters);
        } else {
          return Left(Failure(message: 'Invalid data format from server'));
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

  //* Get Ratings by Slug
  @override
  Future<Either<Failure, List<RatingModel>>> getRatingsRemote({
    required String courseSlug,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getRatings(courseSlug),
      );

      final ApiResponse response = await api.get(request);
      final List<RatingModel> ratings = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List) {
          for (var item in data) {
            ratings.add(RatingModel.fromJson(item));
          }
        }

        return Right(ratings);
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

  //?------------------------------------------------------------------------
  //* getUniversities
  @override
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getUniversities);
      final ApiResponse response = await api.get(request);

      final List<UniversityModel> universities = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List) {
          for (var item in data) {
            universities.add(UniversityModel.fromMap(item));
          }
        }

        return Right(universities);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?----------------------------------------------------------------------------

  //* Add or Remove Favorite Course
  @override
  Future<Either<Failure, bool>> toggleFavoriteCourseRemote({
    required String courseSlug,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.favoriteCourse(courseSlug),
      );

      final ApiResponse response = await api.post(request);

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic> && data.containsKey('is_favorite')) {
          return Right(data['is_favorite'] as bool);
        } else {
          return Left(Failure(message: 'Invalid data format from server'));
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
  //* Get Study Years
  @override
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRemote() async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.getStudyYears);
      final ApiResponse response = await api.get(request);
      final List<StudyYearModel> studyYears = [];

      if (response.statusCode == 200) {
        final data = response.body;

        // نتأكد إن الـ data قائمة
        if (data is Map<String, dynamic> && data['results'] is List) {
          for (var item in data['results']) {
            studyYears.add(StudyYearModel.fromJson(item));
          }
        }

        return Right(studyYears);
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?----------------------------------------------------
}
