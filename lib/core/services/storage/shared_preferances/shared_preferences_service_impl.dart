import 'dart:ui';
import 'package:e_learning/core/constant/cache_keys.dart';
import 'package:e_learning/core/model/enums/app_role_enum.dart';
import 'package:e_learning/core/services/storage/shared_preferances/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServiceImpl implements SharedPreferencesService {
  final SharedPreferences storagePreferences;
  SharedPreferencesServiceImpl({required this.storagePreferences});

  //?---------------- Remove All ------------------------------------------
  @override
  Future<void> removeAll() async {
    try {
      await storagePreferences.clear();
    } catch (_) {}
  }

  //?-------------------- Locale ------------------------------------------

  //* Get
  @override
  Future<String?> getSavedLocaleInCache() async {
    try {
      return storagePreferences.getString(CacheKeys.appLanguageKey);
    } catch (_) {
      return null;
    }
  }

  //* Save
  @override
  Future<void> saveLocaleInCache(String langCode) async {
    try {
      await storagePreferences.setString(CacheKeys.appLanguageKey, langCode);
    } catch (_) {}
  }

  //* Change
  @override
  Future<void> changeLocaleInCache(Locale newLocale) async {
    try {
      await storagePreferences.setString(
        CacheKeys.appLanguageKey,
        newLocale.languageCode,
      );
    } catch (_) {}
  }

  //* Remove
  @override
  Future<void> removeLocaleInCache() async {
    try {
      await storagePreferences.remove(CacheKeys.appLanguageKey);
    } catch (_) {}
  }

  //?-------------------- Role --------------------------------------------

  //* Save Role
  @override
  Future<void> saveRoleInCache(AppRoleEnum role) async {
    try {
      await storagePreferences.setString(
        CacheKeys.appRoleKey,
        role.name.toUpperCase(), // "STUDENT", "TEACHER", "USER"
      );
    } catch (_) {}
  }

  //* Get Role
  @override
  Future<AppRoleEnum?> getRoleInCache() async {
    try {
      final roleString = storagePreferences.getString(CacheKeys.appRoleKey);
      if (roleString == null) return null;

      // البحث عن الـ enum اللي اسمه يساوي القيمة المحفوظة (كبيرة أو صغيرة)
      return AppRoleEnum.values.firstWhere(
        (r) => r.name.toUpperCase() == roleString.toUpperCase(),
        // orElse: () => null, // لو ما لاقى، يرجع null
      );
    } catch (_) {
      return null;
    }
  }

  //?-----------------------------------------------------------------------

  //? ------------------- Enrollment Data Cache Methods --------------------

  //* Save Enrollments
  @override
  Future<void> saveEnrollmentsInCache(String enrollmentsJson) async {
    try {
      await storagePreferences.setString(
        CacheKeys.enrollmentsKey,
        enrollmentsJson,
      );
    } catch (_) {}
  }

  //* Get Enrollments
  @override
  Future<String?> getEnrollmentsInCache() async {
    try {
      return storagePreferences.getString(CacheKeys.enrollmentsKey);
    } catch (_) {
      return null;
    }
  }

  //* Remove Enrollments
  @override
  Future<void> removeEnrollmentsInCache() async {
    try {
      await storagePreferences.remove(CacheKeys.enrollmentsKey);
    } catch (_) {}
  }

  //? ------------------- Course Ratings Cache Methods ---------------------

  //* Save Course Ratings
  @override
  Future<void> saveCourseRatingsInCache(
    String courseSlug,
    String ratingsJson,
  ) async {
    try {
      await storagePreferences.setString(
        '${CacheKeys.courseRatingsKey}$courseSlug',
        ratingsJson,
      );
    } catch (_) {}
  }

  //* Get Course Ratings
  @override
  Future<String?> getCourseRatingsInCache(String courseSlug) async {
    try {
      return storagePreferences.getString(
        '${CacheKeys.courseRatingsKey}$courseSlug',
      );
    } catch (_) {
      return null;
    }
  }

  //* Remove Course Ratings
  @override
  Future<void> removeCourseRatingsInCache(String courseSlug) async {
    try {
      await storagePreferences.remove(
        '${CacheKeys.courseRatingsKey}$courseSlug',
      );
    } catch (_) {}
  }

  //?-----------------------------------------------------------------------
}
