abstract class TokenService {
  //? -------------------------------------------------------------------
  //? ---- Token ----------------

  Future<void> saveTokenService(String token);
  Future<String?> getTokenService();
  Future<void> deleteTokenService();

  //? -------------------------------------------------------------------
  //? ---- Refresh Token ----------------

  Future<void> saveRefreshTokenService(String refreshToken);
  Future<String?> getRefreshTokenService();

  //? -------------------------------------------------------------------
  //? ---- Token Expiry ----------------

  Future<void> saveTokenExpiryService(DateTime expiry);
  Future<DateTime?> getTokenExpiryService();

  //? -------------------------------------------------------------------
  //? ---- General ----------------

  Future<void> clearTokenService();
  Future<bool> hasTokenService();
  Future<bool> isTokenExpiredService();
  Future<void> saveAllTokensService({
    required String accessToken,
    required String refreshToken,
    required DateTime expiry,
  });
}
