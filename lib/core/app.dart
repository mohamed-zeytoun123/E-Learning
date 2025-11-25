import 'package:device_preview/device_preview.dart';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/router/app_router.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/core/theme/app_theme.dart';
import 'package:e_learning/features/profile/data/source/remote/profile_remote_dat_source.dart';
import 'package:e_learning/features/profile/data/source/repo/profile_repository.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Elearning extends StatelessWidget {
  static const instance = Elearning._();
  const Elearning._();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppManagerCubit(),
        ),
        BlocProvider(
          create: (_) => ProfileCubit(
            ProfileRepository(
              remote: di<ProfileRemouteDataSource>(),
              network: di<NetworkInfoService>(),
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
              return MaterialApp.router(
                title: 'e_learning'.tr(),
                debugShowCheckedModeBanner: false,
                useInheritedMediaQuery: true,
                locale: DevicePreview.locale(context) ?? state.appLocale,
                builder: (context, child) =>
                    DevicePreview.appBuilder(context, child),
                themeMode: state.themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                supportedLocales: const [Locale('en'), Locale('ar')],
                localizationsDelegates: [
                  ...context.localizationDelegates,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                routerConfig: AppRouter.configs,
              );
            },
          );
        },
      ),
    );
  }
}
