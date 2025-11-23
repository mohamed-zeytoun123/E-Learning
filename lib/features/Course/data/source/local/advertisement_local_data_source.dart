import 'package:e_learning/features/Course/data/models/advertisment_model.dart';

abstract class AdvertisementLocalDataSource {
  //?----------------------------------------------------

  //* Get Advertisements From Cache
  List<AdvertisementModel> getAdvertisementsInCache();

  //* Save Advertisements To Cache
  Future<void> saveAdvertisementsInCache(
      List<AdvertisementModel> advertisements);

  //?----------------------------------------------------
}

