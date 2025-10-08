import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  //? ---------------- One Step  -----------------------------------------

  await Hive.initFlutter();

  //?---------------- Register Adapter As Arry true --------------------------

  // Hive.registerAdapter(LocationModelAdapter());
  // Hive.registerAdapter(CityModelAdapter());
  // Hive.registerAdapter(RecommendedHotelsModelAdapter());
  // Hive.registerAdapter(HotelModelAdapter());
  // Hive.registerAdapter(BookingModelAdapter());
  // Hive.registerAdapter(RoomTypeModelAdapter());

  //?---------------- Open Box  ---------------------------------------

  // await Hive.openBox<LocationModel>(CacheKeys.locationBox);
  // await Hive.openBox<RecommendedHotelsModel>(CacheKeys.recommendedBoxName);
  // await Hive.openBox<RecommendedHotelsModel>(CacheKeys.topRatedBoxName);
  // await Hive.openBox<HotelModel>(CacheKeys.allHotels);
  // await Hive.openBox(CacheKeys.historySearch);
  // await Hive.openBox<RoomTypeModel>(CacheKeys.room);
  // await Hive.openBox<BookingModel>(CacheKeys.bookingCompleted);
  // await Hive.openBox<BookingModel>(CacheKeys.bookingCanceld);
  // await Hive.openBox<BookingModel>(CacheKeys.bookingPending);
}
