import 'package:dartz/dartz.dart';
import 'package:network/failures/failures.dart';
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

abstract class CourceseRemoteDataSource {
  //?----------------------------------------------------

  //* Get Filter Categories
  Future<Either<Failure, List<CategorieModel>>> getCategoriesRemote();

  //* Get Courses
  Future<Either<Failure, PaginatedCoursesModel>> getCoursesRemote({
    CourseFiltersModel? filters,
    int? page,
    int? pageSize,
    String? ordering,
    String? search,
  });

  //* Get Colleges
  Future<Either<Failure, List<CollegeModel>>> getCollegesRemote();

  //* Get Course Details by Slug
  Future<Either<Failure, CourseDetailsModel>> getCourseDetailsRemote({
    required String courseSlug,
  });

  //* Get Chapters by Slug
  Future<Either<Failure, PaginatedChaptersModel>> getChaptersRemote({
    required String courseId,
    int? page,
    int? pageSize,
  });

  //* Get Ratings by Id Course pagination
  Future<Either<Failure, PaginatedRatingsModel>> getRatingsRemote({
    required String courseId,
    int? page,
    int? pageSize,
    String? ordering,
  });

  //* Get Universities
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRemote();

  //* Add or Remove Favorite Course
  Future<Either<Failure, bool>> toggleFavoriteCourseRemote({
    required String courseSlug,
  });

  //* Get Study Years
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRemote();

  //* Add Rating to Course
  Future<Either<Failure, RatingModel>> addRatingRemote({
    required int rating,
    required String courseId,
    String? comment,
  });

  //* Enroll Cource
  Future<Either<Failure, EnrollmentModel>> enrollCourseRemote({
    required int courseId,
  });

  //* Get Channels
  Future<Either<Failure, List<ChannelModel>>> getChannelsRemote();
  //?----------------------------------------------------
}
