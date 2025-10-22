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
