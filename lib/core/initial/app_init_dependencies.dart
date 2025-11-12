import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_learning/core/app/source/remote/app_manager_remote_data_source.dart';
import 'package:e_learning/core/app/source/remote/app_manager_remote_data_source_impl.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/app_dio.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/core/services/network/network_info_service_impl.dart';
import 'package:e_learning/core/services/storage/hivi/hive_service.dart';
import 'package:e_learning/core/services/storage/hivi/hive_service_impl.dart';
import 'package:e_learning/core/services/storage/secure_storage/secure_storage_service.dart';
import 'package:e_learning/core/services/storage/secure_storage/secure_storage_service_impl.dart';
import 'package:e_learning/core/services/storage/shared_preferances/shared_preferences_service.dart';
import 'package:e_learning/core/services/storage/shared_preferances/shared_preferences_service_impl.dart';
import 'package:e_learning/core/services/token/token_service.dart';
import 'package:e_learning/core/services/token/token_service_impl.dart';
import 'package:e_learning/core/services/translation/translation_service.dart';
import 'package:e_learning/core/services/translation/translation_service_impl.dart';
import 'package:e_learning/features/auth/data/source/local/auth_local_data_source.dart';
import 'package:e_learning/features/auth/data/source/local/auth_local_data_source_impl.dart';
import 'package:e_learning/features/auth/data/source/remote/auth_remote_data_source.dart';
import 'package:e_learning/features/auth/data/source/remote/auth_remote_data_source_impl.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository_impl.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_dat_source.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_data_source_impl.dart';
import 'package:e_learning/features/profile/data/source/repo/profile_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appLocator = GetIt.instance;
final connectivity = Connectivity();
Future<void> appInitDependencies() async {
  //? ----------- Network ------------------------------------------

  //! App Dio
  appLocator.registerLazySingleton<AppDio>(
    () => AppDio(tokenService: appLocator<TokenService>()),
  );

  //! Api
  appLocator.registerLazySingleton<API>(
    () => API(dio: appLocator<AppDio>().dio),
  );

  //! Network Info
  appLocator.registerLazySingleton<NetworkInfoService>(
    () => NetworkInfoServiceImpl(connectivity),
  );

  //! Token
  appLocator.registerLazySingleton<TokenService>(
    () => TokenServiceImpl(secureStorage: appLocator<SecureStorageService>()),
  );

  //? ----------- translation ------------------------------------------------------

  appLocator.registerLazySingleton<TranslationService>(
    () => TranslationServiceImpl(
      storagePreferanceService: appLocator<SharedPreferencesService>(),
    ),
  );

  //? ----------- Storage -----------------------------------------------------------

  //! Flutter Secure Storage
  appLocator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  //! Secure Storage Service
  appLocator.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(storage: appLocator<FlutterSecureStorage>()),
  );

  //! Shared Preferences
  final sharedPrefs = await SharedPreferences.getInstance();
  appLocator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //! Shared Preferences Service
  appLocator.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesServiceImpl(
      storagePreferences: appLocator<SharedPreferences>(),
    ),
  );

  //! Hive Service
  appLocator.registerLazySingleton<HiveService>(() => HiveServiceImpl());
  //? ----------- Local Data Sources --------------------------------------------------

  //! App Manager local
  // appLocator.registerLazySingleton<AppLocalDataSource>(
  //   () => AppLocalDataSourceImpl(
  //     secureStorage: appLocator<SecureStorageService>(),
  //     preferencesStorage: appLocator<SharedPreferencesService>(),
  //     translationService: appLocator<TranslationService>(),
  //     locationService: appLocator<LocationService>(),
  //   ),
  // );

  //* Auth local
  appLocator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      tokenService: appLocator<TokenService>(),
      secureStorage: appLocator<SecureStorageService>(),
      preferencesStorage: appLocator<SharedPreferencesService>(),
    ),
  );

  //? ----------- Remote Data Sources -----------------------------------------------------------

  //! App Manager Remote
  appLocator.registerLazySingleton<AppManagerRemoteDataSource>(
    () => AppManagerRemoteDataSourceImpl(
      tokenService: appLocator<TokenService>(),
      api: appLocator<API>(),

      // secureStorage: appLocator<SecureStorageService>(),
      // preferencesStorage: appLocator<SharedPreferencesService>(),
      // translationService: appLocator<TranslationService>(),
    ),
  );

  //* Auth Remote
  appLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(api: appLocator<API>()),
  );

  //? ----------- Repositories ------------------------------------------------------------------

  //* Auth Repository
  appLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: appLocator<AuthRemoteDataSource>(),
      local: appLocator<AuthLocalDataSource>(),
      network: appLocator<NetworkInfoService>(),
    ),
  );
  //?-----------Repository Profile------------------------------------------------------------------------------------

  appLocator.registerLazySingleton<ProfileRemouteDataSource>(
    () => ProfileRemoteDataSourceImpl(api: appLocator<API>()),
  );

  appLocator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(
      remote: appLocator<ProfileRemouteDataSource>(),
      network: appLocator<NetworkInfoService>(),
    ),
  );

  //?-----------------------------------------------------------------------------------

  //? --------------------------------------------------------------------------------------------
}
