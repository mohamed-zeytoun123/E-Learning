import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/app_colors_extension.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.backgroundPage,
      onSurface: AppColors.textBlack,
      error: AppColors.textError,
    ),
    scaffoldBackgroundColor: AppColors.backgroundPage,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
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
        backgroundOrange :AppColors.formSomeWhite,
        //* Text Colors
        textPrimary: AppColors.textBlack,
        textBlack: AppColors.textBlack,
        textGrey: AppColors.textGrey,
        textError: AppColors.textError,
        textWhite: AppColors.textWhite,
        textRed: AppColors.textRed,
        textSilver: AppColors.textSilver,
        textBlue: AppColors.borderPrimary,
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
        borderCard:Colors.transparent,
        
        //* Loading Colors
        loadingPrimary: AppColors.loadingPrimary,
        loadingBackground: AppColors.loadingBackground,

        //* Message Colors
        messageSuccess: AppColors.messageSuccess,
        messageError: AppColors.messageError,
        messageWarning: AppColors.messageWarning,
        messageInfo: AppColors.messageInfo,

        //* App Bar Colors
        appBarBlack: AppColors.appBarlightTop,
        appBarWhite: AppColors.appBarlightbottom,

        //* Icon Colors
        iconWhite: AppColors.textBlack,
        iconGrey: AppColors.iconGrey,
        iconBlack: AppColors.iconBlue,
        iconError: AppColors.iconError,
        iconRed: AppColors.iconRed,

        //*  Form Colors
        formWhite: AppColors.appBarlightbottom,

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
        backgroundOrange :AppColors.retingback,
        
        //* Text Colors
        textPrimary: AppColors.textWhite,
        textBlack: AppColors.textBlack,
        textGrey: AppColors.lightGrey,
        textError: AppColors.textError,
        textWhite: AppColors.textWhite,
        textRed: AppColors.textRed,
        textSilver: AppColors.textSilver,
        textBlue: AppColors.backgroundDarkSecondary,
        //* Button Colors
        buttonPrimary: Colors.white,
        buttonSecondary: AppColors.buttonSecondary,
        buttonWhite: AppColors.buttonPrimary,
        buttonGreyF: AppColors.buttonGreyF,

        //? Tab Bar
        buttonTapSelected: AppColors.buttonTapSelected,
        buttonTapNotSelected: AppColors.buttontapped,

        //* Title Button Colors
        titlePrimary: Colors.black,
        titleBlack: AppColors.titlePrimary,
        titleGrey: AppColors.titleGrey,

        //* Border Colors
        borderPrimary: AppColors.borderPrimary,
        borderSecondary: AppColors.borderSecondary,
        borderBrand: AppColors.borderSecondary,
        borderCard:AppColors.borderPrimaryDark,
        //* Loading Colors
        loadingPrimary: AppColors.loadingPrimary,
        loadingBackground: AppColors.loadingBackground,

        //* Message Colors
        messageSuccess: AppColors.messageSuccess,
        messageError: AppColors.messageError,
        messageWarning: AppColors.messageWarning,
        messageInfo: AppColors.messageInfo,

        //* App Bar Colors
        appBarBlack: AppColors.appBarbarktop,
        appBarWhite: AppColors.appBarbarkbottom,

        //* Icon Colors\
        iconWhite: AppColors.iconWhite,
        iconGrey: AppColors.iconGrey,
        iconBlack: AppColors.iconWhite,
        iconError: AppColors.iconError,
        iconRed: AppColors.iconRed,
        

        //*  Form Colors
        formWhite: AppColors.textBlack,

        //* Divider Colors
        dividerGrey: AppColors.borderPrimaryDark,


        //* text Colors 
        
      ),
    ],
  );
}
