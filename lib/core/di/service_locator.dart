import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:netwoek/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

import 'package:e_learning/core/app/source/remote/app_manager_remote_data_source.dart';
import 'package:e_learning/core/app/source/remote/app_manager_remote_data_source_impl.dart';

import 'package:e_learning/features/auth/data/source/local/auth_local_data_source.dart';
import 'package:e_learning/features/auth/data/source/local/auth_local_data_source_impl.dart';
import 'package:e_learning/features/auth/data/source/remote/auth_remote_data_source.dart';
import 'package:e_learning/features/auth/data/source/remote/auth_remote_data_source_impl.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository_impl.dart';

import 'package:e_learning/features/Course/data/source/local/courcese_local_data_source.dart';
import 'package:e_learning/features/Course/data/source/local/courcese_local_data_source_impl.dart';
import 'package:e_learning/features/Course/data/source/remote/courcese_remote_data_source.dart';
import 'package:e_learning/features/Course/data/source/remote/courcese_remote_data_source_impl.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository_impl.dart';

import 'package:e_learning/features/chapter/data/source/local/chapter_local_data_source.dart';
import 'package:e_learning/features/chapter/data/source/local/chapter_local_data_source_impl.dart';
import 'package:e_learning/features/chapter/data/source/remote/chapter_remote_data_source.dart';
import 'package:e_learning/features/chapter/data/source/remote/chapter_remote_data_source_impl.dart';
import 'package:e_learning/features/chapter/data/source/repo/chapter_repository.dart';
import 'package:e_learning/features/chapter/data/source/repo/chapter_repository_impl.dart';

import 'package:e_learning/features/Teacher/data/source/local/teacher_local_data_source.dart';
import 'package:e_learning/features/Teacher/data/source/local/teacher_local_data_source_impl.dart';
import 'package:e_learning/features/Teacher/data/source/remote/teacher_remote_data_source.dart';
import 'package:e_learning/features/Teacher/data/source/remote/teacher_remote_data_source_impl.dart';
import 'package:e_learning/features/Teacher/data/source/repo/teacher_repository.dart';
import 'package:e_learning/features/Teacher/data/source/repo/teacher_repository_impl.dart';

import 'package:e_learning/features/Article/data/source/local/article_local_data_source.dart';
import 'package:e_learning/features/Article/data/source/local/article_local_data_source_impl.dart';
import 'package:e_learning/features/Article/data/source/remote/article_remote_data_source.dart';
import 'package:e_learning/features/Article/data/source/remote/article_remote_data_source_impl.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository_impl.dart';

import 'package:e_learning/features/Course/data/source/local/advertisement_local_data_source.dart';
import 'package:e_learning/features/Course/data/source/local/advertisement_local_data_source_impl.dart';
import 'package:e_learning/features/Course/data/source/remote/advertisement_remote_data_source.dart';
import 'package:e_learning/features/Course/data/source/remote/advertisement_remote_data_source_impl.dart';
import 'package:e_learning/features/Course/data/source/repo/advertisement_repository.dart';
import 'package:e_learning/features/Course/data/source/repo/advertisement_repository_impl.dart';

import 'package:e_learning/features/profile/data/source/remote/profile_remote_dat_source.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_data_source_impl.dart';
import 'package:e_learning/features/profile/data/source/repo/profile_repository.dart';

import 'package:e_learning/features/enroll/data/source/local/enroll_local_data_source.dart';
import 'package:e_learning/features/enroll/data/source/local/enroll_local_data_source_impl.dart';
import 'package:e_learning/features/enroll/data/source/remote/enroll_remote_data_source.dart';
import 'package:e_learning/features/enroll/data/source/remote/enroll_remote_data_source_impl.dart';
import 'package:e_learning/features/enroll/data/source/repo/enroll_repository.dart';
import 'package:e_learning/features/enroll/data/source/repo/enroll_repository_impl.dart';

final di = GetIt.instance;
final connectivity = Connectivity();

Future<void> initDependencyInjection() async {
  _initNetworkDependecies();

  await _initStorageDependecies();

  _initCoreServicesDependecies();

  _initAuthDependecies();

  _initCourseDependecies();

  _initChapterDependecies();

  _initTeacherDependecies();

  _initArticleDependecies();

  _initAdvertisementDependecies();

  _initProfileDependecies();

  _initEnrollDependecies();

  _initAppManagerDependecies();
}

_initNetworkDependecies() {
  di.registerLazySingleton<AppDio>(() => AppDio());
  di.registerLazySingleton<APICallManager>(() => APICallManagerImpl());
  di.registerLazySingleton<API>(
    () => ApiImpl(di<AppDio>().instance),
  );
}

Future<void> _initStorageDependecies() async {
  di.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  di.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(storage: di<FlutterSecureStorage>()),
  );

  final sharedPrefs = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  di.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesServiceImpl(
      storagePreferences: di<SharedPreferences>(),
    ),
  );

  di.registerLazySingleton<HiveService>(() => HiveServiceImpl());
}

_initCoreServicesDependecies() {
  di.registerLazySingleton<NetworkInfoService>(
    () => NetworkInfoServiceImpl(connectivity),
  );

  di.registerLazySingleton<TokenService>(
    () => TokenServiceImpl(secureStorage: di<SecureStorageService>()),
  );
}

_initAuthDependecies() {
  di.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      tokenService: di<TokenService>(),
      secureStorage: di<SecureStorageService>(),
      preferencesStorage: di<SharedPreferencesService>(),
    ),
  );

  di.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      api: di<API>(),
      apiCallManager: di<APICallManager>(),
    ),
  );

  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: di<AuthRemoteDataSource>(),
      local: di<AuthLocalDataSource>(),
      network: di<NetworkInfoService>(),
    ),
  );
}

_initCourseDependecies() {
  di.registerLazySingleton<CourceseLocalDataSource>(
    () => CourceseLocalDataSourceImpl(hive: di<HiveService>()),
  );

  di.registerLazySingleton<CourceseRemoteDataSource>(
    () => CourceseRemoteDataSourceImpl(api: di<API>()),
  );

  di.registerLazySingleton<CourceseRepository>(
    () => CourceseRepositoryImpl(
      remote: di<CourceseRemoteDataSource>(),
      local: di<CourceseLocalDataSource>(),
      network: di<NetworkInfoService>(),
    ),
  );
}

_initChapterDependecies() {
  di.registerLazySingleton<ChapterLocalDataSource>(
    () => ChapterLocalDataSourceImpl(hive: di<HiveService>()),
  );

  di.registerLazySingleton<ChapterRemoteDataSource>(
    () => ChapterRemoteDataSourceImpl(api: di<API>()),
  );

  di.registerLazySingleton<ChapterRepository>(
    () => ChapterRepositoryImpl(
      remote: di<ChapterRemoteDataSource>(),
      local: di<ChapterLocalDataSource>(),
      network: di<NetworkInfoService>(),
    ),
  );
}

_initTeacherDependecies() {
  di.registerLazySingleton<TeacherLocalDataSource>(
    () => TeacherLocalDataSourceImpl(
      sharedPreferences: di<SharedPreferences>(),
    ),
  );

  di.registerLazySingleton<TeacherRemoteDataSource>(
    () => TeacherRemoteDataSourceImpl(api: di<API>()),
  );

  di.registerLazySingleton<TeacherRepository>(
    () => TeacherRepositoryImpl(
      remote: di<TeacherRemoteDataSource>(),
      local: di<TeacherLocalDataSource>(),
      network: di<NetworkInfoService>(),
    ),
  );
}

_initArticleDependecies() {
  di.registerLazySingleton<ArticleLocalDataSource>(
    () => ArticleLocalDataSourceImpl(
      sharedPreferences: di<SharedPreferences>(),
    ),
  );

  di.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(
      api: di<API>(),
    ),
  );

  di.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(
      remote: di<ArticleRemoteDataSource>(),
      local: di<ArticleLocalDataSource>(),
      network: di<NetworkInfoService>(),
    ),
  );
}

_initAdvertisementDependecies() {
  di.registerLazySingleton<AdvertisementLocalDataSource>(
    () => AdvertisementLocalDataSourceImpl(
      sharedPreferences: di<SharedPreferences>(),
    ),
  );

  di.registerLazySingleton<AdvertisementRemoteDataSource>(
    () => AdvertisementRemoteDataSourceImpl(api: di<API>()),
  );

  di.registerLazySingleton<AdvertisementRepository>(
    () => AdvertisementRepositoryImpl(
      remote: di<AdvertisementRemoteDataSource>(),
      local: di<AdvertisementLocalDataSource>(),
      network: di<NetworkInfoService>(),
    ),
  );
}

_initProfileDependecies() {
  di.registerLazySingleton<ProfileRemouteDataSource>(
    () => ProfileRemoteDataSourceImpl(api: di<API>()),
  );

  di.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(
      remote: di<ProfileRemouteDataSource>(),
      network: di<NetworkInfoService>(),
    ),
  );
}

_initEnrollDependecies() {
  di.registerLazySingleton<EnrollLocalDataSource>(
    () => EnrollLocalDataSourceImpl(
      sharedPreferences: di<SharedPreferencesService>(),
    ),
  );

  di.registerLazySingleton<EnrollRemoteDataSource>(
    () => EnrollRemoteDataSourceImpl(
      api: di<API>(),
      tokenService: di<TokenService>(),
    ),
  );

  di.registerLazySingleton<EnrollRepository>(
    () => EnrollRepositoryImpl(
      remoteDataSource: di<EnrollRemoteDataSource>(),
      localDataSource: di<EnrollLocalDataSource>(),
      networkInfo: di<NetworkInfoService>(),
    ),
  );
}

_initAppManagerDependecies() {
  di.registerLazySingleton<AppManagerRemoteDataSource>(
    () => AppManagerRemoteDataSourceImpl(
      tokenService: di<TokenService>(),
      api: di<API>(),
    ),
  );
}
