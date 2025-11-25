import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:netwoek/network.dart';
import 'package:netwoek/network/api/api_request.dart';
import 'package:netwoek/network/api/api_response.dart';
import 'package:e_learning/core/model/paginated_model.dart';
import 'package:e_learning/features/Course/data/models/course_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/enrollment_model.dart';
import 'package:e_learning/features/Course/data/models/rating_model.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model.dart';
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
      final ApiRequest request = ApiRequest(
        url: AppUrls.getCategories,
        headers: ApiRequestParameters.authHeaders,
      );

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
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
  //* Get Courses
  @override
  Future<Either<Failure, PaginationModel<CourseModel>>> getCoursesRemote({
    CourseFiltersModel? filters,
    int? page,
    int? pageSize,
    String? ordering,
    String? search,
  }) async {
    try {
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
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final paginatedCourses = PaginationModel<CourseModel>.fromJson(data, (json) => CourseModel.fromJson(json as Map<String, dynamic>));
          return Right(paginatedCourses);
        } else {
          return Left(Failure(message: 'Invalid data format from server'));
        }
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
  //* Get Colleges
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote() async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getColleges,
        headers: ApiRequestParameters.authHeaders,
      );

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
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
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
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final courseDetails = CourseDetailsModel.fromMap(data);
          return Right(courseDetails);
        } else {
          return Left(Failure(message: 'Server error'));
        }
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------

  //* Get Chapters by Course (With Pagination)
  @override
  Future<Either<Failure, PaginationModel<ChapterModel>>> getChaptersRemote({
    required String courseId,
    int? page,
    int? pageSize,
  }) async {
    try {
      // تجهيز query parameters
      final Map<String, dynamic> queryParameters = {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getChapters(courseId, queryParameters: queryParameters),
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data['results'] is List) {
          final paginatedChapters = PaginationModel<ChapterModel>.fromJson(data, (json) => ChapterModel.fromJson(json as Map<String, dynamic>));
          return Right(paginatedChapters);
        } else {
          return Left(Failure(message: 'Invalid data format from server'));
        }
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------

  //* Get Ratings by Course with Pagination
  @override
  Future<Either<Failure, PaginationModel<RatingModel>>> getRatingsRemote({
    required String courseId,
    int? page,
    int? pageSize,
    String? ordering,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
        if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getRatings(courseId, queryParameters: queryParameters),
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data['results'] is List) {
          final paginatedRatings = PaginationModel<RatingModel>.fromJson(data, (json) => RatingModel.fromJson(json as Map<String, dynamic>));
          return Right(paginatedRatings);
        } else {
          return Left(Failure(message: 'Invalid data format from server'));
        }
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?------------------------------------------------------------------------
  //* getUniversities
  @override
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRemote() async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getUniversities,
        headers: ApiRequestParameters.authHeaders,
      );
      final ApiResponse response = await api.get(request);

      final List<UniversityModel> universities = [];

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map && data['results'] is List) {
          final results = data['results'] as List;
          for (var item in results) {
            universities.add(UniversityModel.fromMap(item));
          }
        } else if (data != null && data is List<dynamic>) {
          final listData = data as List<dynamic>;
          for (var item in listData) {
            universities.add(UniversityModel.fromMap(item));
          }
        }

        return Right(universities);
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
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
        headers: ApiRequestParameters.authHeaders,
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
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
  //* Get Study Years
  @override
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRemote() async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getStudyYears,
        headers: ApiRequestParameters.authHeaders,
      );
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
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
  //* Add Rating to Course
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
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.post(request);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final newRating = RatingModel.fromJson(data);
          return Right(newRating);
        } else {
          return Left(Failure(message: "Invalid data format from server"));
        }
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
  //* Enroll Cource
  @override
  Future<Either<Failure, EnrollmentModel>> enrollCourseRemote({
    required int courseId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.enrollCourse,
        body: {'course_id': courseId},
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.post(request);

      if (response.statusCode == 201) {
        final data = response.body;
        if (data is Map<String, dynamic> && data.containsKey('enrollment')) {
          final enrollment = EnrollmentModel.fromJson(data['enrollment']);
          return Right(enrollment);
        } else {
          return Left(Failure(message: 'Invalid data format from server'));
        }
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
}
