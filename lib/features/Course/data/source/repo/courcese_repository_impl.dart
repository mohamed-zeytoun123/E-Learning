import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';
import 'package:e_learning/features/Course/data/models/course_model/course_model.dart';
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
  Future<Either<Failure, List<CategorieModel>>>
      getFilterCategoriesRepo() async {
    if (await network.isConnected) {
      final result = await remote.getFilterCategoriesRemote();

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
  //* Get Courses
  @override
  Future<Either<Failure, List<CourseModel>>> getCoursesRepo(
      {int? categoryId}) async {
    if (await network.isConnected) {
      final result = await remote.getCoursesRemote(categoryId: categoryId);

      return result.fold((failure) {
        print('❌ Repository: Remote call failed - ${failure.message}');
        return Left(failure);
      }, (courses) async {
        print('📦 Repository: Received ${courses.length} courses from remote');
        // Allow empty lists - let UI handle showing "No courses available"
        if (courses.isNotEmpty && categoryId == null) {
          // Only cache when fetching all courses, not filtered
          await local.saveCoursesInCache(courses);
        }
        return Right(courses);
      });
    } else {
      final cachedCourses = local.getCoursesInCache();

      if (cachedCourses.isNotEmpty) {
        print(
            '📦 Repository: Loaded ${cachedCourses.length} courses from cache');
        // If filtering by category and we're offline, filter cached courses
        if (categoryId != null) {
          // Note: CourseModel doesn't have category field, so offline filtering won't work
          // For now, return all cached courses when offline and filtering
        }
        return Right(cachedCourses);
      } else {
        print('❌ Repository: No cached courses available');
        return Left(FailureNoConnection());
      }
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
  Future<Either<Failure, List<ChapterModel>>> getChaptersRepo({
    required int courseId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getChaptersRemote(courseId: courseId);
      return result.fold(
        (failure) => Left(failure),
        (chapters) => Right(chapters),
      );
    } else {
      return Left(FailureNoConnection());
    }
  }
  //? -----------------------------------------------------------------
}
