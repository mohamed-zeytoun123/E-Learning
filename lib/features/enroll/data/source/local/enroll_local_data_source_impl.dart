import 'dart:convert';
import 'package:e_learning/core/services/storage/shared_preferances/shared_preferences_service.dart';
import 'package:e_learning/features/enroll/data/models/course_rating_response.dart';
import 'package:e_learning/features/enroll/data/models/enrollment_model.dart';
import 'package:e_learning/features/enroll/data/source/local/enroll_local_data_source.dart';

class EnrollLocalDataSourceImpl implements EnrollLocalDataSource {
  final SharedPreferencesService sharedPreferences;

  EnrollLocalDataSourceImpl({required this.sharedPreferences});

  //? ====================== Enrollment Management =========================

  @override
  Future<void> saveEnrollmentsLocal(List<EnrollmentModel> enrollments) async {
    try {
      final enrollmentsJson = enrollments.map((e) => e.toJson()).toList();
      final jsonString = jsonEncode(enrollmentsJson);
      await sharedPreferences.saveEnrollmentsInCache(jsonString);
    } catch (_) {}
  }

  @override
  Future<List<EnrollmentModel>?> getEnrollmentsLocal() async {
    try {
      final jsonString = await sharedPreferences.getEnrollmentsInCache();
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => EnrollmentModel.fromJson(json)).toList();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearEnrollmentsLocal() async {
    try {
      await sharedPreferences.removeEnrollmentsInCache();
    } catch (_) {}
  }

  //? ====================== Course Ratings Cache ==========================

  @override
  Future<void> saveCourseRatingsLocal(
    String courseSlug,
    CourseRatingResponse ratingsResponse,
  ) async {
    try {
      final jsonString = jsonEncode(ratingsResponse.toJson());
      await sharedPreferences.saveCourseRatingsInCache(courseSlug, jsonString);
    } catch (_) {}
  }

  @override
  Future<CourseRatingResponse?> getCourseRatingsLocal(String courseSlug) async {
    try {
      final jsonString = await sharedPreferences.getCourseRatingsInCache(
        courseSlug,
      );
      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }
      final json = jsonDecode(jsonString);
      return CourseRatingResponse.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearCourseRatingsLocal(String courseSlug) async {
    try {
      await sharedPreferences.removeCourseRatingsInCache(courseSlug);
    } catch (_) {}
  }

  @override
  Future<void> clearAllCourseRatingsLocal() async {
    try {
      // For now, we can't clear all course ratings without access to getKeys
      // This would need to be implemented by extending the SharedPreferencesService interface
      // or by keeping track of course slugs separately
    } catch (_) {}
  }
}
