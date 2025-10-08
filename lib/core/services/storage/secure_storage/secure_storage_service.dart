abstract class SecureStorageService {

  //? ----------------------- User -----------------------------------------------

  // //* Save
  // Future<void> saveDataUserInCache(AuthResponseModel user) async {
  //   try {
  //     final encodedData = jsonEncode(user.toJson());
  //     await storage.write(
  //       key: CacheKeys.userData,
  //       value: encodedData,
  //     );
  //   } catch (_) {}
  // }

  // //* Remove
  // Future<void> cleareDataUserInCache() async {
  //   try {
  //     await storage.deleteAll();
  //   } catch (_) {}
  // }

  // //* Get
  // Future<AuthResponseModel?> getUserFromInCache() async {
  //   try {
  //     final jsonString = await storage.read(key: CacheKeys.userData);
  //     if (jsonString == null) return null;
  //     return AuthResponseModel.fromJson(jsonString);
  //   } catch (_) {
  //     return null;
  //   }
  // }
  //? -------------------------------------------------------------------------------
}
