import 'package:e_learning/features/Banner/data/models/banner_model/banner_model.dart';

abstract class BannerLocalDataSource {
  //?----------------------------------------------------

  //* Get Banners From Cache
  List<BannerModel> getBannersInCache();

  //* Save Banners To Cache
  Future<void> saveBannersInCache(List<BannerModel> banners);

  //?----------------------------------------------------
}

