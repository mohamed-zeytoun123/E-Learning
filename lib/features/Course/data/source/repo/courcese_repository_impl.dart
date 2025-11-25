// ignore_for_file: void_checks

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Course/data/models/courses_result_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/enrollment_model.dart';
import 'package:e_learning/features/Course/data/models/rating_model.dart';
import 'package:e_learning/features/Course/data/models/ratings_result_model.dart';

import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapters_result_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';
import 'package:e_learning/features/Course/data/source/local/courcese_local_data_source.dart';
import 'package:e_learning/features/Course/data/source/remote/courcese_remote_data_source.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';

class CourceseRepositoryImpl implements CourceseRepository {
  final CourceseRemoteDataSource remote;
  final CourceseLocalDataSource local;
  final NetworkInfoService network;

  CourceseRepositoryImpl({
    required this.remote,
    required this.local,
    required this.network,
  });

  //? -----------------------------------------------------------------
  //* Get Filter Categories
  @override
  Future<Either<Failure, List<CategorieModel>>> getCategoriesRepo() async {
    if (await network.isConnected) {
      final result = await remote.getCategoriesRemote();

      return result.fold((failure) => Left(failure), (categories) async {
        if (categories.isEmpty) return Left(Failure(message: 'No data available'));
        await local.saveCategoriesInCash(categories);
        return Right(categories);
      });
    } else {
      final cachedCategories = local.getCategoriesInCach();

      if (cachedCategories.isNotEmpty) {
        return Right(cachedCategories);
      } else {
        return Left(Failure(message: 'No internet connection'));
      }
    }
  }

  //? -----------------------------------------------------------------
  //* Get Courses with Pagination
  @override
  Future<Either<Failure, CoursesResultModel>> getCoursesRepo({
    CourseFiltersModel? filters,
    int? teacherId,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  }) async {
    try {
      filters ??= local.getFilters();

      if (await network.isConnected) {
        final result = await remote.getCoursesRemote(
          filters: filters,
          search: search,
          ordering: ordering,
          page: page,
          pageSize: pageSize,
        );

        return await result.fold((failure) async => Left(failure), (
          paginatedCourses,
        ) async {
          final courses = paginatedCourses.results ?? [];

          if (courses.isEmpty) return Left(Failure(message: 'No data available'));

          if (page == null || page == 1) {
            await local.saveCoursesInCache(courses);
          } else {
            await local.appendCoursesToCache(courses);
          }

          if (filters != null) {
            await local.saveFilters(filters);
          }

          return Right(
            CoursesResultModel(
              courses: courses,
              hasNextPage: paginatedCourses.next != null,
            ),
          );
        });
      } else {
        final cachedCourses = local.getCoursesInCache();
        if (cachedCourses.isNotEmpty) {
          return Right(
            CoursesResultModel(courses: cachedCourses, hasNextPage: false),
          );
        } else {
          return Left(Failure(message: 'No internet connection'));
        }
      }
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //? -----------------------------------------------------------------
  //* Get Colleges
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRepo() async {
    if (await network.isConnected) {
      final result = await remote.getCollegesRemote();

      return result.fold((failure) => Left(failure), (colleges) async {
        if (colleges.isEmpty) return Left(Failure(message: 'No data available'));
        await local.saveCollegesInCache(colleges);
        return Right(colleges);
      });
    } else {
      final cachedColleges = local.getCollegesInCache();

      if (cachedColleges.isNotEmpty) {
        return Right(cachedColleges);
      } else {
        return Left(Failure(message: 'No internet connection'));
      }
    }
  }

  //? -----------------------------------------------------------------

  //* Get Course Details
  @override
  Future<Either<Failure, CourseDetailsModel>> getCourseDetailsRepo({
    required String courseSlug,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getCourseDetailsRemote(
        courseSlug: courseSlug,
      );

      return result.fold((failure) => Left(failure), (courseDetails) {
        return Right(courseDetails);
      });
    } else {
      return Left(Failure(message: 'No internet connection'));
    }
  }

  //? -----------------------------------------------------------------

  //* Get Chapters by Course
  @override
  Future<Either<Failure, ChaptersResultModel>> getChaptersRepo({
    required String courseId,
    int? page,
    int? pageSize,
  }) async {
    try {
      if (await network.isConnected) {
        final result = await remote.getChaptersRemote(
          courseId: courseId,
          page: page,
          pageSize: pageSize,
        );

        return result.fold((failure) => Left(failure), (paginatedChapters) {
          final chapters = paginatedChapters.results;

          return Right(
            ChaptersResultModel(
              chapters: chapters,
              hasNextPage:
                  paginatedChapters.currentPage < paginatedChapters.totalPages,
            ),
          );
        });
      } else {
        return Left(Failure(message: 'No internet connection'));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //? -----------------------------------------------------------------

  //* Get Ratings by Course (Repository)
  @override
  Future<Either<Failure, RatingsResultModel>> getRatingsRepo({
    required String courseId,
    int? page,
    int? pageSize,
    String? ordering,
  }) async {
    try {
      if (await network.isConnected) {
        final result = await remote.getRatingsRemote(
          courseId: courseId,
          page: page,
          pageSize: pageSize,
          ordering: ordering,
        );

        return result.fold((failure) => Left(failure), (paginatedRatings) {
          final ratings = paginatedRatings.results;

          if (ratings.isEmpty) return Left(Failure(message: 'No data available'));

          return Right(
            RatingsResultModel(
              ratings: ratings,
              hasNextPage:
                  paginatedRatings.currentPage < paginatedRatings.totalPages,
            ),
          );
        });
      } else {
        // لو بدك ممكن تعمل هنا cache لاحقًا
        return Left(Failure(message: 'No internet connection'));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
    }
  }

  //?--------------------------------------------------------
  //* Get Universities
  @override
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRepo() async {
    if (await network.isConnected) {
      final result = await remote.getUniversitiesRemote();

      return result.fold((failure) => Left(failure), (universities) async {
        if (universities.isEmpty) return Left(Failure(message: 'No data available'));
        await local.saveUniversitiesInCache(universities);
        return Right(universities);
      });
    } else {
      final cachedUniversities = local.getUniversitiesInCache();

      if (cachedUniversities.isNotEmpty) {
        return Right(cachedUniversities);
      } else {
        return Left(Failure(message: 'No internet connection'));
      }
    }
  }

  //?----------------------------------------------------

  //* Toggle Favorite Course
  @override
  Future<Either<Failure, bool>> toggleFavoriteCourseRepo({
    required String courseSlug,
  }) async {
    if (await network.isConnected) {
      final result = await remote.toggleFavoriteCourseRemote(
        courseSlug: courseSlug,
      );

      return result.fold(
        (failure) => Left(failure),
        (isFavorite) => Right(isFavorite),
      );
    } else {
      return Left(Failure(message: 'No internet connection'));
    }
  }

  //?----------------------------------------------------

  //* Get Study Years
  @override
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRepo() async {
    if (await network.isConnected) {
      final result = await remote.getStudyYearsRemote();

      return result.fold((failure) => Left(failure), (years) async {
        if (years.isEmpty) return Left(Failure(message: 'No data available'));
        await local.saveStudyYearsInCache(years);
        return Right(years);
      });
    } else {
      final cachedYears = local.getStudyYearsInCache();
      if (cachedYears.isNotEmpty) {
        return Right(cachedYears);
      } else {
        return Left(Failure(message: 'No internet connection'));
      }
    }
  }

  //?----------------------------------------------------

  //* Add Rating
  @override
  Future<Either<Failure, RatingModel>> addRatingRepo({
    required int rating,
    required String courseId,
    String? comment,
  }) async {
    if (await network.isConnected) {
      try {
        final result = await remote.addRatingRemote(
          rating: rating,
          courseId: courseId,
          comment: comment,
        );

        return result.fold(
          (failure) => Left(failure),
          (ratingModel) => Right(ratingModel),
        );
      } catch (e) {
        if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(Failure(message: 'No internet connection'));
    }
  }

  //? -----------------------------------------------------------------
  //* Enroll in a Course
  @override
  Future<Either<Failure, EnrollmentModel>> enrollCourseRepo({
    required int courseId,
  }) async {
    if (await network.isConnected) {
      try {
        final result = await remote.enrollCourseRemote(courseId: courseId);

        return result.fold(
          (failure) => Left(failure),
          (enrollment) => Right(enrollment),
        );
      } catch (e) {
        if (e is DioException && e.response != null) {
          final data = e.response?.data;
          if (data != null && data['non_field_errors'] != null) {
            return Left(Failure(message: data['non_field_errors'][0]));
          }
        }
        if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(Failure(message: 'No internet connection'));
    }
  }

  //?----------------------------------------------------
}
