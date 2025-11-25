import 'package:e_learning/core/model/enums/app_enums.dart';

abstract class AuthLocalDataSource {
  //? ---------------------- Save All Tokens ----------------------------
  Future<void> saveAllTokensLocal({
    required String accessToken,
    required String refreshToken,
  });

  //? ---------------------- Access Token -------------------------------
  Future<void> saveTokenLocal(String token);
  Future<String?> getTokenLocal();
  Future<void> deleteTokenLocal();

  //? ---------------------- Refresh Token ------------------------------
  Future<void> saveRefreshTokenLocal(String refreshToken);
  Future<String?> getRefreshTokenLocal();

  //? ---------------------- Clear All Tokens ---------------------------
  Future<void> clearTokenLocal();

  //? ---- Role ---------------------------------------------------------
  Future<void> saveRoleLocal(AppRoleEnum role);
  Future<AppRoleEnum?> getRoleLocal();
}
