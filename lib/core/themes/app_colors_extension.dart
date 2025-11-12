import 'package:flutter/material.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.background,
    required this.backgroundDark,
    required this.textPrimary,
    required this.textBlack,
    required this.textGrey,
    required this.textError,
    required this.textWhite,
    required this.textRed,
    required this.buttonPrimary,
    required this.buttonSecondary,
    required this.buttonWhite,
    required this.buttonGreyF,
    required this.buttonTapSelected,
    required this.buttonTapNotSelected,
    required this.titlePrimary,
    required this.titleBlack,
    required this.titleGrey,
    required this.borderPrimary,
    required this.borderSecondary,
    required this.borderBrand,
    required this.loadingPrimary,
    required this.loadingBackground,
    required this.messageSuccess,
    required this.messageError,
    required this.messageWarning,
    required this.messageInfo,
    required this.appBarBlack,
    required this.appBarWhite,
    required this.iconWhite,
    required this.iconGrey,
    required this.iconBlack,
    required this.iconError,
    required this.iconRed,
    required this.formWhite,
    required this.dividerGrey,
    required this.textBlue,
    required this.borderCard,
  });

  final Color background;
  final Color backgroundDark;
  final Color textPrimary;
  final Color textBlack;
  final Color textGrey;
  final Color textError;
  final Color textWhite;
  final Color textRed;
  final Color buttonPrimary;
  final Color buttonSecondary;
  final Color buttonWhite;
  final Color buttonGreyF;
  final Color buttonTapSelected;
  final Color buttonTapNotSelected;
  final Color titlePrimary;
  final Color titleBlack;
  final Color titleGrey;
  final Color borderPrimary;
  final Color borderSecondary;
  final Color borderBrand;
  final Color loadingPrimary;
  final Color loadingBackground;
  final Color messageSuccess;
  final Color messageError;
  final Color messageWarning;
  final Color messageInfo;
  final Color appBarBlack;
  final Color appBarWhite;
  final Color iconWhite;
  final Color iconGrey;
  final Color iconBlack;
  final Color iconError;
  final Color iconRed;
  final Color formWhite;
  final Color dividerGrey;
  final Color textBlue;
  final Color borderCard;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? background,
    Color? backgroundDark,
    Color? textPrimary,
    Color? textBlack,
    Color? textGrey,
    Color? textError,
    Color? textWhite,
    Color? textRed,
    Color? buttonPrimary,
    Color? buttonSecondary,
    Color? buttonWhite,
    Color? buttonGreyF,
    Color? buttonTapSelected,
    Color? buttonTapNotSelected,
    Color? titlePrimary,
    Color? titleBlack,
    Color? titleGrey,
    Color? borderPrimary,
    Color? borderSecondary,
    Color? borderBrand,
    Color? loadingPrimary,
    Color? loadingBackground,
    Color? messageSuccess,
    Color? messageError,
    Color? messageWarning,
    Color? messageInfo,
    Color? appBarBlack,
    Color? appBarWhite,
    Color? iconWhite,
    Color? iconGrey,
    Color? iconBlack,
    Color? iconError,
    Color? iconRed,
    Color? formWhite,
    Color? dividerGrey,
    Color? textBlue,
    Color? borderCard,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      textPrimary: textPrimary ?? this.textPrimary,
      textBlack: textBlack ?? this.textBlack,
      textGrey: textGrey ?? this.textGrey,
      textError: textError ?? this.textError,
      textWhite: textWhite ?? this.textWhite,
      textRed: textRed ?? this.textRed,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      buttonSecondary: buttonSecondary ?? this.buttonSecondary,
      buttonWhite: buttonWhite ?? this.buttonWhite,
      buttonGreyF: buttonGreyF ?? this.buttonGreyF,
      buttonTapSelected: buttonTapSelected ?? this.buttonTapSelected,
      buttonTapNotSelected: buttonTapNotSelected ?? this.buttonTapNotSelected,
      titlePrimary: titlePrimary ?? this.titlePrimary,
      titleBlack: titleBlack ?? this.titleBlack,
      titleGrey: titleGrey ?? this.titleGrey,
      borderPrimary: borderPrimary ?? this.borderPrimary,
      borderSecondary: borderSecondary ?? this.borderSecondary,
      borderBrand: borderBrand ?? this.borderBrand,
      loadingPrimary: loadingPrimary ?? this.loadingPrimary,
      loadingBackground: loadingBackground ?? this.loadingBackground,
      messageSuccess: messageSuccess ?? this.messageSuccess,
      messageError: messageError ?? this.messageError,
      messageWarning: messageWarning ?? this.messageWarning,
      messageInfo: messageInfo ?? this.messageInfo,
      appBarBlack: appBarBlack ?? this.appBarBlack,
      appBarWhite: appBarWhite ?? this.appBarWhite,
      iconWhite: iconWhite ?? this.iconWhite,
      iconGrey: iconGrey ?? this.iconGrey,
      iconBlack: iconBlack ?? this.iconBlack,
      iconError: iconError ?? this.iconError,
      iconRed: iconRed ?? this.iconRed,
      formWhite: formWhite ?? this.formWhite,
      dividerGrey: dividerGrey ?? this.dividerGrey,
      textBlue: textBlue ?? this.textBlue,
      borderCard: borderCard ?? this.borderCard,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      background: Color.lerp(background, other.background, t)!,
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textBlack: Color.lerp(textBlack, other.textBlack, t)!,
      textGrey: Color.lerp(textGrey, other.textGrey, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textWhite: Color.lerp(textWhite, other.textWhite, t)!,
      textRed: Color.lerp(textRed, other.textRed, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonSecondary: Color.lerp(buttonSecondary, other.buttonSecondary, t)!,
      buttonWhite: Color.lerp(buttonWhite, other.buttonWhite, t)!,
      buttonGreyF: Color.lerp(buttonGreyF, other.buttonGreyF, t)!,
      buttonTapSelected: Color.lerp(
        buttonTapSelected,
        other.buttonTapSelected,
        t,
      )!,
      buttonTapNotSelected: Color.lerp(
        buttonTapNotSelected,
        other.buttonTapNotSelected,
        t,
      )!,
      titlePrimary: Color.lerp(titlePrimary, other.titlePrimary, t)!,
      titleBlack: Color.lerp(titleBlack, other.titleBlack, t)!,
      titleGrey: Color.lerp(titleGrey, other.titleGrey, t)!,
      borderPrimary: Color.lerp(borderPrimary, other.borderPrimary, t)!,
      borderSecondary: Color.lerp(borderSecondary, other.borderSecondary, t)!,
      borderBrand: Color.lerp(borderBrand, other.borderBrand, t)!,
      loadingPrimary: Color.lerp(loadingPrimary, other.loadingPrimary, t)!,
      loadingBackground: Color.lerp(
        loadingBackground,
        other.loadingBackground,
        t,
      )!,
      messageSuccess: Color.lerp(messageSuccess, other.messageSuccess, t)!,
      messageError: Color.lerp(messageError, other.messageError, t)!,
      messageWarning: Color.lerp(messageWarning, other.messageWarning, t)!,
      messageInfo: Color.lerp(messageInfo, other.messageInfo, t)!,
      appBarBlack: Color.lerp(appBarBlack, other.appBarBlack, t)!,
      appBarWhite: Color.lerp(appBarWhite, other.appBarWhite, t)!,
      iconWhite: Color.lerp(iconWhite, other.iconWhite, t)!,
      iconGrey: Color.lerp(iconGrey, other.iconGrey, t)!,
      iconBlack: Color.lerp(iconBlack, other.iconBlack, t)!,
      iconError: Color.lerp(iconError, other.iconError, t)!,
      iconRed: Color.lerp(iconRed, other.iconRed, t)!,
      formWhite: Color.lerp(formWhite, other.formWhite, t)!,
      dividerGrey: Color.lerp(dividerGrey, other.dividerGrey, t)!,
      textBlue: Color.lerp(textBlue, other.textBlue, t)!,
      borderCard: Color.lerp(borderCard, other.borderCard, t)!,
    );
  }
}
