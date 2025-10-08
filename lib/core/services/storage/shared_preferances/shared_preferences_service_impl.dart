import 'dart:ui';
import 'package:e_learning/core/constant/cache_keys.dart';
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

  //?-------------------- Locale  ------------------------------------------

  //* Get
  @override
  Future<String?> getSavedLocaleInCache() async {
    try {
      return storagePreferences.getString(CacheKeys.appLanguage);
    } catch (_) {
      return null;
    }
  }

  //* Save
  @override
  Future<void> saveLocaleInCache(String langCode) async {
    try {
      await storagePreferences.setString(CacheKeys.appLanguage, langCode);
    } catch (_) {}
  }

  //* Change
  @override
  Future<void> changeLocaleInCache(Locale newLocale) async {
    try {
      await storagePreferences.setString(
        CacheKeys.appLanguage,
        newLocale.languageCode,
      );
    } catch (_) {}
  }

  //* Remove
  @override
  Future<void> removeLocaleInCache() async {
    try {
      await storagePreferences.remove(CacheKeys.appLanguage);
    } catch (_) {}
  }

  //?-----------------------------------------------------------------------
}
