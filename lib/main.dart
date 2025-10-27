import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/initial/hivi_init.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/router/app_router.dart';
import 'package:e_learning/core/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await appInitDependencies();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', ''), Locale('ar', '')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en', ''),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppManagerCubit(), //todo || add function get user info
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<AppManagerCubit, AppManagerState>(
            builder: (context, state) {
              return MaterialApp.router(

                title: 'E-Learning',
                debugShowCheckedModeBanner: false,
      locale: context.locale,
                themeMode: state.themeMode,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
      supportedLocales: context.supportedLocales,
                 localizationsDelegates: context.localizationDelegates,

                
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
