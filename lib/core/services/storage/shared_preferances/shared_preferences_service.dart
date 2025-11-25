import 'dart:ui';

import 'package:e_learning/core/model/enums/app_enums.dart';

abstract class SharedPreferencesService {
  //? -------------------------------------------------------------------
  //* Log Out
  Future<void> removeAll();

  //? -------------------------

  //* Locale
  Future<void> changeLocaleInCache(Locale newLocale);
  Future<void> saveLocaleInCache(String langCode);
  Future<void> removeLocaleInCache();
  Future<String?> getSavedLocaleInCache();

  //* Role
  Future<void> saveRoleInCache(AppRoleEnum role);
  Future<AppRoleEnum?> getRoleInCache();

  //* Enrollments
  Future<void> saveEnrollmentsInCache(String enrollmentsJson);
  Future<String?> getEnrollmentsInCache();
  Future<void> removeEnrollmentsInCache();

  //* Course Ratings
  Future<void> saveCourseRatingsInCache(String courseSlug, String ratingsJson);
  Future<String?> getCourseRatingsInCache(String courseSlug);
  Future<void> removeCourseRatingsInCache(String courseSlug);

  //? -------------------------------------------------------------------
}
