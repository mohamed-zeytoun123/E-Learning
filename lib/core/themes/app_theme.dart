import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/app_colors_extension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.buttonPrimary,
      secondary: AppColors.buttonSecondary,
      surface: AppColors.backgroundPage,
      onSurface: AppColors.textBlack,
      error: AppColors.textError,
    ),
    scaffoldBackgroundColor: AppColors.backgroundPage,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBarBlack,
      titleTextStyle: AppTextStyles.s18w600.copyWith(
        color: AppColors.textWhite,
      ),
      foregroundColor: AppColors.textWhite,
    ),
    extensions: [
      AppColorsExtension(
        //* Primary Colors
        background: AppColors.backgroundPage,
        backgroundDark: AppColors.backgroundDarkPage,

        //* Text Colors
        textPrimary: AppColors.textPrimary,
        textBlack: AppColors.textBlack,
        textGrey: AppColors.textGrey,
        textError: AppColors.textError,
        textWhite: AppColors.textWhite,
        textRed: AppColors.textRed,

        //* Button Colors
        buttonPrimary: AppColors.buttonPrimary,
        buttonSecondary: AppColors.buttonSecondary,
        buttonWhite: AppColors.buttonWhite,
        buttonGreyF: AppColors.buttonGreyF,

        //? Tab Bar
        buttonTapSelected: AppColors.buttonTapSelected,
        buttonTapNotSelected: AppColors.buttonTapNotSelected,

        //* Title Button Colors
        titlePrimary: AppColors.titlePrimary,
        titleBlack: AppColors.titleBlack,
        titleGrey: AppColors.titleGrey,

        //* Border Colors
        borderPrimary: AppColors.borderPrimary,
        borderSecondary: AppColors.borderSecondary,
        borderBrand: AppColors.borderBrand,

        //* Loading Colors
        loadingPrimary: AppColors.loadingPrimary,
        loadingBackground: AppColors.loadingBackground,

        //* Message Colors
        messageSuccess: AppColors.messageSuccess,
        messageError: AppColors.messageError,
        messageWarning: AppColors.messageWarning,
        messageInfo: AppColors.messageInfo,

        //* App Bar Colors
        appBarBlack: AppColors.appBarBlack,
        appBarWhite: AppColors.appBarWhite,

        //* Icon Colors
        iconWhite: AppColors.iconWhite,
        iconGrey: AppColors.iconGrey,
        iconBlack: AppColors.iconBlue,
        iconError: AppColors.iconError,
        iconRed: AppColors.iconRed,

        //*  Form Colors
        formWhite: AppColors.formWhite,

        //* Divider Colors
        dividerGrey: AppColors.dividerGrey,
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.buttonSecondary,
      secondary: AppColors.buttonPrimary,
      surface: AppColors.backgroundDarkPage,
      onSurface: AppColors.textWhite,
      error: AppColors.textError,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDarkPage,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appBarWhite,
      titleTextStyle: AppTextStyles.s18w600.copyWith(
        color: AppColors.textBlack,
      ),
      foregroundColor: AppColors.textBlack,
    ),

    extensions: [
      AppColorsExtension(
        //* Primary Colors
        background: AppColors.backgroundDarkPage,
        backgroundDark: AppColors.backgroundDarkPage,

        //* Text Colors
        textPrimary: AppColors.textWhite,
        textBlack: AppColors.textBlack,
        textGrey: AppColors.textGrey,
        textError: AppColors.textError,
        textWhite: AppColors.textWhite,
        textRed: AppColors.textRed,

        //* Button Colors
        buttonPrimary: Colors.white,
        buttonSecondary: AppColors.buttonSecondary,
        buttonWhite: AppColors.buttonPrimary,
        buttonGreyF: AppColors.buttonGreyF,

        //? Tab Bar
        buttonTapSelected: AppColors.buttonTapSelected,
        buttonTapNotSelected: AppColors.buttonTapNotSelected,

        //* Title Button Colors
        titlePrimary: Colors.black,
        titleBlack: AppColors.titlePrimary,
        titleGrey: AppColors.titleGrey,

        //* Border Colors
        borderPrimary: AppColors.borderPrimary,
        borderSecondary: AppColors.borderSecondary,
        borderBrand: AppColors.borderSecondary,
        //* Loading Colors
        loadingPrimary: AppColors.loadingPrimary,
        loadingBackground: AppColors.loadingBackground,

        //* Message Colors
        messageSuccess: AppColors.messageSuccess,
        messageError: AppColors.messageError,
        messageWarning: AppColors.messageWarning,
        messageInfo: AppColors.messageInfo,

        //* App Bar Colors
        appBarBlack: AppColors.appBarBlack,
        appBarWhite: AppColors.appBarWhite,

        //* Icon Colors\
        iconWhite: AppColors.iconWhite,
        iconGrey: AppColors.iconGrey,
        iconBlack: AppColors.iconWhite,
        iconError: AppColors.iconError,
        iconRed: AppColors.iconRed,

        //*  Form Colors
        formWhite: AppColors.formWhite,

        //* Divider Colors
        dividerGrey: AppColors.dividerGrey,
      ),
    ],
  );
}
