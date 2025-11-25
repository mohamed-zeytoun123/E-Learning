import 'package:e_learning/features/Course/data/models/enrollment_model.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_response.dart';

abstract class EnrollLocalDataSource {
  //? ---------------------- Enrollment Management ----------------------------

  /// Save enrollments list to local cache
  Future<void> saveEnrollmentsLocal(List<EnrollmentModel> enrollments);

  /// Get cached enrollments list
  Future<List<EnrollmentModel>?> getEnrollmentsLocal();

  /// Clear cached enrollments
  Future<void> clearEnrollmentsLocal();

  //? ---------------------- Course Ratings Cache ----------------------------

  /// Save course ratings for a specific course slug
  Future<void> saveCourseRatingsLocal(
    String courseSlug,
    CourseRatingResponse ratingsResponse,
  );

  /// Get cached course ratings for a specific course slug
  Future<CourseRatingResponse?> getCourseRatingsLocal(String courseSlug);

  /// Clear course ratings cache for a specific course
  Future<void> clearCourseRatingsLocal(String courseSlug);

  /// Clear all course ratings cache
  Future<void> clearAllCourseRatingsLocal();
}

