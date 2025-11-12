import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/courses_result/courses_result_model.dart';
import 'package:e_learning/features/Course/data/models/course_filters_model/course_filters_model.dart';
import 'package:e_learning/features/Course/data/models/rating_model.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/study_year_model/study_year_model.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/chapter_model.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/paginated_chapters_model.dart';
import 'package:e_learning/features/Course/data/models/categorie_model/categorie_model.dart';
import 'package:e_learning/features/Course/data/models/course_details_model.dart';
import 'package:e_learning/features/Course/data/models/Pag_courses/course_model/course_model.dart';

abstract class CourceseRepository {
  //?-------------------------------------------------
  //* Get Filter Categories
  Future<Either<Failure, List<CategorieModel>>> getCategoriesRepo();

  //* Get Courses
  Future<Either<Failure, CoursesResultModel>> getCoursesRepo({
    CourseFiltersModel? filters,
    int? teacherId,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  });

  //* Get Colleges
  Future<Either<Failure, List<CollegeModel>>> getCollegesRepo();

  //* Get Course Details
  Future<Either<Failure, CourseDetailsModel>> getCourseDetailsRepo({
    required String courseSlug,
  });

  //* Get Chapters by Course
  Future<Either<Failure, List<ChapterModel>>> getChaptersRepo({
    required String courseSlug,
  });

  //* Get Ratings by Course
  Future<Either<Failure, List<RatingModel>>> getRatingsRepo({
    required String courseSlug,
  });

  //* Get Universities
  Future<Either<Failure, List<UniversityModel>>> getUniversitiesRepo();

  //* Toggle Favorite Course
  Future<Either<Failure, bool>> toggleFavoriteCourseRepo({
    required String courseSlug,
  });

  //* Get Study Years
  Future<Either<Failure, List<StudyYearModel>>> getStudyYearsRepo();
  //?-------------------------------------------------
}
