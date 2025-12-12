import 'package:device_preview/device_preview.dart';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/initial/hivi_init.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/app_router.dart';
import 'package:e_learning/core/themes/app_theme.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/core/services/translation/translation_service.dart';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_dat_source.dart';
import 'package:e_learning/features/profile/data/source/repo/profile_repository.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await appInitDependencies();

  // Load saved locale from storage
  final translationService = di<TranslationService>();
  final savedLocaleCode = await translationService.getSavedLocaleService();
  final startLocale =
      savedLocaleCode != null ? Locale(savedLocaleCode) : const Locale('en');

  await EasyLocalization.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: true, // Set to false to disable device preview
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: startLocale,
        saveLocale: true, // Save locale automatically
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Use a constant key for MaterialApp to preserve router state
  static const _materialAppKey = ValueKey('material_app');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppManagerCubit(), //todo || add function get user info
        ),
        BlocProvider(
          create: (_) => ProfileCubit(
            ProfileRepository(
              remote: appLocator<ProfileRemouteDataSource>(),
              network: appLocator<NetworkInfoService>(),
            ),
          )..getDataUserInfoProfile(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<AppManagerCubit, AppManagerState>(
            builder: (context, state) {
              // Get locale - accessing context.locale here ensures it updates when locale changes
              final currentLocale = context.locale;

              return MaterialApp.router(
                // Use constant key to preserve router state when locale changes
                key: _materialAppKey,
                title: 'e_learning'.tr(),
                debugShowCheckedModeBanner: false,
                locale: currentLocale,
                builder: DevicePreview.appBuilder, // Add DevicePreview builder
                themeMode: state.themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: [
                  ...context.localizationDelegates,
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
