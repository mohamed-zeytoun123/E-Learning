import 'package:e_learning/core/themes/app_colors_extension.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>() ??
      AppColorsExtension(
        background: const Color(0xffFFFFFF),
        backgroundDark: const Color(0xff000000),
        textPrimary: const Color(0xff181818),
        textBlack: const Color(0xff282828),
        textGrey: const Color(0xff737373),
        textError: Colors.red,
        textWhite: const Color(0xffFFFFFF),
        textRed: const Color(0xffDE4C3C),
        buttonPrimary: const Color(0xff181818),
        buttonSecondary: const Color(0xffBABABA),
        buttonWhite: const Color(0xffFFFFFF),
        buttonGreyF: const Color(0xffEAEAEA),
        buttonTapSelected: const Color(0xffDADADA),
        buttonTapNotSelected: const Color(0xffF1F1F1),
        titlePrimary: const Color(0xffFFFFFF),
        titleBlack: const Color(0xff282828),
        titleGrey: const Color(0xff737373),
        borderPrimary: const Color(0xff181818),
        borderSecondary: const Color(0xffBABABA),
        borderBrand: const Color(0xffEAEAEA),
        loadingPrimary: const Color(0xff181818),
        loadingBackground: const Color(0xffEAEAEA),
        messageSuccess: const Color(0xff28A745),
        messageError: const Color(0xffDC3545),
        messageWarning: const Color(0xffFFC107),
        messageInfo: const Color(0xff17A2B8),
        appBarBlack: const Color(0xff333333),
        appBarWhite: const Color(0xffF1F1F1),
        iconWhite: const Color(0xffFFFFFF),
        iconGrey: const Color(0xff737373),
        iconBlack: const Color(0xff181818),
        iconError: Colors.red,
        iconRed: const Color(0xffDE4C3C),
        formWhite: const Color(0xffF1F1F1),
        dividerGrey: const Color(0xffF1F1F1),
        textBlue: const Color(0xff0071C7),
        borderCard: const Color(0xffEAEAEA),
      );
}
