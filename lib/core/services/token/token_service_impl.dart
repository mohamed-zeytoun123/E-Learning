import 'package:e_learning/core/services/storage/secure_storage/secure_storage_service.dart';
import 'package:e_learning/core/services/token/token_service.dart';

class TokenServiceImpl implements TokenService {
  final SecureStorageService secureStorage;

  TokenServiceImpl({required this.secureStorage});

  //? -------------------------------------------------------------------
  //? ---- Token ----------------

  //* saveTokenService
  @override
  Future<void> saveTokenService(String token) async {
    await secureStorage.saveTokenInCach(token);
  }

  //* getTokenService
  @override
  Future<String?> getTokenService() async {
    return await secureStorage.getTokenInCach();
  }

  //* deleteTokenService
  @override
  Future<void> deleteTokenService() async {
    await secureStorage.deleteTokenInCach();
  }

  //? -------------------------------------------------------------------
  //? ---- Refresh Token ----------------

  //* saveRefreshTokenService
  @override
  Future<void> saveRefreshTokenService(String refreshToken) async {
    await secureStorage.saveRefreshTokenInCach(refreshToken);
  }

  //* getRefreshTokenService
  @override
  Future<String?> getRefreshTokenService() async {
    return await secureStorage.getRefreshTokenInCach();
  }

  //? -------------------------------------------------------------------
  //? ---- Token Expiry ----------------

  //* saveTokenExpiryService
  @override
  Future<void> saveTokenExpiryService(DateTime expiry) async {
    await secureStorage.saveTokenExpiryInCach(expiry);
  }

  //* getTokenExpiryService
  @override
  Future<DateTime?> getTokenExpiryService() async {
    return await secureStorage.getTokenExpiryInCach();
  }

  //? -------------------------------------------------------------------
  //? ---- General ----------------

  //* clearTokenService
  @override
  Future<void> clearTokenService() async {
    await secureStorage.removeAllInCach();
  }

  //* hasTokenService
  @override
  Future<bool> hasTokenService() async {
    final token = await getTokenService();
    return token != null && token.isNotEmpty;
  }

  //* isTokenExpiredService
  @override
  Future<bool> isTokenExpiredService() async {
    final expiry = await getTokenExpiryService();
    if (expiry == null) return true;

    final now = DateTime.now();
    final bufferTime = Duration(minutes: 5);
    return now.isAfter(expiry.subtract(bufferTime));
  }

  //* saveAllTokensService
  @override
  Future<void> saveAllTokensService({
    required String accessToken,
    required String refreshToken,
    required DateTime expiry,
  }) async {
    await saveTokenService(accessToken);
    await saveRefreshTokenService(refreshToken);
    await saveTokenExpiryService(expiry);
  }

  //? -------------------------------------------------------------------
}
