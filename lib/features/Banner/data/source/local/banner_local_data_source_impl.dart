import 'package:e_learning/core/constant/cache_keys.dart';
import 'package:e_learning/features/Banner/data/models/banner_model/banner_model.dart';
import 'package:e_learning/features/Banner/data/source/local/banner_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BannerLocalDataSourceImpl implements BannerLocalDataSource {
  final SharedPreferences sharedPreferences;

  BannerLocalDataSourceImpl({required this.sharedPreferences});

  @override
  List<BannerModel> getBannersInCache() {
    try {
      final jsonString = sharedPreferences.getString(CacheKeys.bannerBox);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => BannerModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveBannersInCache(List<BannerModel> banners) async {
    try {
      final jsonList = banners.map((banner) => banner.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(CacheKeys.bannerBox, jsonString);
    } catch (e) {
      // Handle error silently
    }
  }
}

