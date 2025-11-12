import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/courses_result/courses_result_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/rating_model.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/chapter_model.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/paginated_chapters_model.dart';
import 'package:e_learning/features/course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/course/data/models/course_details_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';
import 'package:e_learning/features/course/data/source/local/courcese_local_data_source.dart';
import 'package:e_learning/features/course/data/source/remote/courcese_remote_data_source.dart';
import 'package:e_learning/features/course/data/source/repo/courcese_repository.dart';

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
        if (categories.isEmpty) return Left(FailureNoData());
        await local.saveCategoriesInCash(categories);
        return Right(categories);
      });
    } else {
      final cachedCategories = local.getCategoriesInCach();

      if (cachedCategories.isNotEmpty) {
        return Right(cachedCategories);
      } else {
        return Left(FailureNoConnection());
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

      log(
        'Applying filters Repo : college=${filters?.collegeId}, studyYear=${filters?.studyYear}, category=${filters?.categoryId}, page=$page, pageSize=$pageSize',
      );

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

          if (courses.isEmpty) return Left(FailureNoData());

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
          return Left(FailureNoConnection());
        }
      }
    } catch (e) {
      log('getCoursesRepo Error: $e');
      return Left(Failure.handleError(e as DioException));
    }
  }

  //? -----------------------------------------------------------------
  //* Get Colleges
  @override
  Future<Either<Failure, List<CollegeModel>>> getCollegesRepo() async {
    if (await network.isConnected) {
      final result = await remote.getCollegesRemote();

      return result.fold((failure) => Left(failure), (colleges) async {
        if (colleges.isEmpty) return Left(FailureNoData());
        await local.saveCollegesInCache(colleges);
        return Right(colleges);
      });
    } else {
      final cachedColleges = local.getCollegesInCache();

      if (cachedColleges.isNotEmpty) {
        return Right(cachedColleges);
      } else {
        return Left(FailureNoConnection());
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
      return Left(FailureNoConnection());
    }
  }

  //? -----------------------------------------------------------------

  //* Get Chapters by Course
  @override
  Future<Either<Failure, List<ChapterModel>>> getChaptersRepo({
    required String courseSlug,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getChaptersRemote(courseSlug: courseSlug);
      return result.fold(
        (failure) => Left(failure),
        (chapters) => Right(chapters.results),
      );
    } else {
      return Left(FailureNoConnection());
    }
  }

  //? -----------------------------------------------------------------

  //* Get Ratings by Course
  @override
  Future<Either<Failure, List<RatingModel>>> getRatingsRepo({
    required String courseSlug,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getRatingsRemote(courseSlug: courseSlug);

      return result.fold((failure) => Left(failure), (ratings) {
        if (ratings.isEmpty) return Left(FailureNoData());
        return Right(ratings);
      });
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?--------------------------------------------------------
  //* Get Universities
  @override
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRepo() async {
    if (await network.isConnected) {
      final result = await remote.getUniversitiesRemote();

      return result.fold((failure) => Left(failure), (universities) async {
        if (universities.isEmpty) return Left(FailureNoData());
        await local.saveUniversitiesInCache(universities);
        return Right(universities);
      });
    } else {
      final cachedUniversities = local.getUniversitiesInCache();

      if (cachedUniversities.isNotEmpty) {
        return Right(cachedUniversities);
      } else {
        return Left(FailureNoConnection());
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
      return Left(FailureNoConnection());
    }
  }

  //?----------------------------------------------------

  //* Get Study Years
  @override
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRepo() async {
    if (await network.isConnected) {
      final result = await remote.getStudyYearsRemote();

      return result.fold((failure) => Left(failure), (years) async {
        if (years.isEmpty) return Left(FailureNoData());
        await local.saveStudyYearsInCache(years);
        return Right(years);
      });
    } else {
      final cachedYears = local.getStudyYearsInCache();
      if (cachedYears.isNotEmpty) {
        return Right(cachedYears);
      } else {
        return Left(FailureNoConnection());
      }
    }
  }

  //?----------------------------------------------------
}
