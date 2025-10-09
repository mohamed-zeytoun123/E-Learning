abstract class SecureStorageService {
  //? ----------------------- Token -----------------------------------------

  //* saveTokenInCach
  Future<void> saveTokenInCach(String token);

  //* getTokenInCach
  Future<String?> getTokenInCach();

  //* deleteTokenInCach
  Future<void> deleteTokenInCach();

  //? ------------------- Refresh Token -------------------------------------

  //* saveRefreshTokenInCach
  Future<void> saveRefreshTokenInCach(String refreshToken);

  //* getRefreshTokenInCach
  Future<String?> getRefreshTokenInCach();

  //? ------------------- Token Expiry --------------------------------------

  //* saveTokenExpiryInCach
  Future<void> saveTokenExpiryInCach(DateTime expiry);

  //* getTokenExpiryInCach
  Future<DateTime?> getTokenExpiryInCach();

  //? ------------------- Remove All ----------------------------------------

  //* removeAllInCach
  Future<void> removeAllInCach();
  //?---------------------------------
}
