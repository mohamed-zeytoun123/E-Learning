import 'dart:ui';

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

  //? -------------------------------------------------------------------
}
