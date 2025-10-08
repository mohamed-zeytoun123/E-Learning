import 'package:e_learning/core/services/storage/hivi/hive_service.dart';

class HiveServiceImpl implements HiveService {
  //?-------  Open Box   ---------------------------------------------------------------

  //* location Box
  // final Box<LocationModel> locationBox =
  //     Hive.box<LocationModel>(CacheKeys.locationBox);

  //?-----   Location  --------------------------------------------------------------------------------

  // //* حفظ موقع جديد    إضافة موقع واحد فقط للصندوق بدون ما يمسح الموجود.
  // @override
  // Future<void> saveLocationInListHestoryInCache(LocationModel location) async {
  //   await locationBox.add(location); // يضيف موقع جديد
  // }

  // //* حفظ قائمة كاملة     : يبدّل كل المحتويات بمواقع جديدة.
  // @override
  // Future<void> saveLocationsInCache(List<LocationModel> locations) async {
  //  await  Future.wait([
  //     locationBox.clear(),
  //     locationBox.addAll(locations),
  //   ]);
  // }

  // //* جلب كل المواقع
  // @override
  // List<LocationModel> getLocationsInCache() {
  //   return locationBox.values.toList();
  // }

  // //* حذف موقع معين
  // @override
  // Future<void> removeLocationInCache(int index) async {
  //   await locationBox.deleteAt(index);
  // }

  // //* حذف كل المواقع
  // @override
  // Future<void> clearAllInCache() async {
  //   await locationBox.clear();
  // }
  //?-------------------------------------------------------------------------------------
}
