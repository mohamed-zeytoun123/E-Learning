import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit()
    : super(
        const AppManagerState(
          appLocale: Locale('en'),
          themeMode: ThemeMode.light,
          appState: AppStateEnum.user,
          token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoyNjYyMTcwNDc1LCJpYXQiOjE3NjIxNzA0NzUsImp0aSI6IjBhNzM2MjNhZmJhYzQxYjdhMTYzNzUxMzE0NjUxNjY0IiwidXNlcl9pZCI6IjIiLCJyb2xlIjoiU1RVREVOVCJ9.H5DYscdVIi2OcgdNRZ4zsdcBBqB397o63JmHYXXzPig',
        ),
      );

  //?--------  App Local  -------------------------------------------------------------

  //* Toogle to Arabic
  void toArabic() {
    emit(state.copyWith(appLocale: const Locale('ar')));
  }

  //* Toogle to English
  void toEnglish() {
    emit(state.copyWith(appLocale: const Locale('en')));
  }

  //* Toogle Dynamic
  void toggleLanguage() {
    emit(
      state.copyWith(
        appLocale: state.appLocale.languageCode == 'ar'
            ? const Locale('en')
            : const Locale('ar'),
      ),
    );
  }

  //?--------- Theme  ------------------------------------------------------------

  //* Toogle Theme
  void toggleTheme() {
    emit(
      state.copyWith(
        themeMode: state.themeMode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light,
      ),
    );
  }

  //* Set Theme Mode
  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  //?---------------------------------------------------------------------
}
