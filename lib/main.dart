import 'package:device_preview/device_preview.dart';
import 'package:e_learning/core/app.dart';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/local_storage/hivi_init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await initDependencyInjection();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => EasyLocalization(
        // supportedLocales: [Locale('en', ''), Locale('ar', '')],
        supportedLocales: [ Locale('en', '')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en', ''),
        child: Elearning.instance,
      ),
    ),
  );
}
