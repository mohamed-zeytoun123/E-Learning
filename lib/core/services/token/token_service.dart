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
  //? ---- General ----------------

  Future<void> clearTokenService();
  Future<bool> hasTokenService();
  Future<void> saveAllTokensService({
    required String accessToken,
    required String refreshToken,
  });
}
