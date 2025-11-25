import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/services/storage/secure_storage/secure_storage_service.dart';
import 'package:e_learning/core/services/storage/shared_preferances/shared_preferences_service.dart';
import 'package:e_learning/core/services/token/token_service.dart';
import 'package:e_learning/features/auth/data/source/local/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService secureStorage;
  final SharedPreferencesService preferencesStorage;
  final TokenService tokenService;

  AuthLocalDataSourceImpl({
    required this.secureStorage,
    required this.preferencesStorage,
    required this.tokenService,
  });
  //? -----------------------------------------------------------------
  @override
  Future<void> saveAllTokensLocal({
    required String accessToken,
    required String refreshToken,
  }) async {
    await tokenService.saveAllTokensService(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  //? ---- Token ----------------
  @override
  Future<void> saveTokenLocal(String token) async {
    await tokenService.saveTokenService(token);
  }

  @override
  Future<String?> getTokenLocal() async {
    return await tokenService.getTokenService();
  }

  @override
  Future<void> deleteTokenLocal() async {
    await tokenService.deleteTokenService();
  }

  //? ---- Refresh Token ----------------
  @override
  Future<void> saveRefreshTokenLocal(String refreshToken) async {
    await tokenService.saveRefreshTokenService(refreshToken);
  }

  @override
  Future<String?> getRefreshTokenLocal() async {
    return await tokenService.getRefreshTokenService();
  }

  //? ---- Clear Tokens ----------------

  @override
  Future<void> clearTokenLocal() async {
    await tokenService.clearTokenService();
  }

  //? ---- Role ----------------
  @override
  Future<void> saveRoleLocal(AppRoleEnum role) async {
    await preferencesStorage.saveRoleInCache(role);
  }

  @override
  Future<AppRoleEnum?> getRoleLocal() async {
    return await preferencesStorage.getRoleInCache();
  }

  //? -----------------------------------------------------------------
}
