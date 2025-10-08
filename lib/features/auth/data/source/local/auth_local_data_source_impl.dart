import 'package:e_learning/core/services/storage/secure_storage/secure_storage_service.dart';
import 'package:e_learning/core/services/storage/shared_preferances/shared_preferences_service.dart';
import 'package:e_learning/features/auth/data/source/local/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService secureStorage;
  final SharedPreferencesService preferencesStorage;

  AuthLocalDataSourceImpl({
    required this.secureStorage,
    required this.preferencesStorage,
  });
  //? -----------------------------------------------------------------
  //? -----------------------------------------------------------------
}
