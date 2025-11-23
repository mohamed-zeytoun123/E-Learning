import 'package:e_learning/features/Course/data/models/advertisment_model.dart';
import 'package:e_learning/features/Course/data/source/local/advertisement_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AdvertisementLocalDataSourceImpl
    implements AdvertisementLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _cacheKey = 'cached_advertisements';

  AdvertisementLocalDataSourceImpl({required this.sharedPreferences});

  //?--- Advertisements -------------------------------------------------

  //* Get Advertisements From Cache
  @override
  List<AdvertisementModel> getAdvertisementsInCache() {
    try {
      final cachedData = sharedPreferences.getString(_cacheKey);
      if (cachedData != null) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList
            .map((json) =>
                AdvertisementModel.fromMap(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  //* Save Advertisements To Cache
  @override
  Future<void> saveAdvertisementsInCache(
      List<AdvertisementModel> advertisements) async {
    try {
      final jsonList =
          advertisements.map((advertisement) => advertisement.toMap()).toList();
      await sharedPreferences.setString(_cacheKey, json.encode(jsonList));
    } catch (_) {}
  }

  //?----------------------------------------------------
}

