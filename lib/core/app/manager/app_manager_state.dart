import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:flutter/material.dart';

class AppManagerState {
  //? -------------------------------------------
  //* App Local
  final Locale appLocale;

  //* App Them
  final ThemeMode themeMode;

  //* App State
  final AppStateEnum appState;

  final String token;

  //? -------------------------------------------

  const AppManagerState({
    required this.appLocale,
    required this.token,
    required this.themeMode,
    required this.appState,
  });

  AppManagerState copyWith({
    Locale? appLocale,
    ThemeMode? themeMode,
    AppStateEnum? appState,
    String? token,
  }) {
    return AppManagerState(
      token: token ?? this.token,
      appLocale: appLocale ?? this.appLocale,
      appState: appState ?? this.appState,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  //? -------------------------------------------
}
