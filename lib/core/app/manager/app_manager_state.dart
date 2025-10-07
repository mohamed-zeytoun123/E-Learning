import 'package:flutter/material.dart';

class AppManagerState {
  //? -------------------------------------------
  //* App Local
  final Locale appLocale ;
  final ThemeMode themeMode;

  //? -------------------------------------------

  const AppManagerState({required this.appLocale, required this.themeMode});

  AppManagerState copyWith({Locale? appLocale, ThemeMode? themeMode}) {
    return AppManagerState(
      appLocale: appLocale ?? this.appLocale,
      themeMode: themeMode ?? this.themeMode,
    );
  }
  //? -------------------------------------------
}
