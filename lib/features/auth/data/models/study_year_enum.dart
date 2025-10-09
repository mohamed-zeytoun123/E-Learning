import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:flutter/material.dart';

enum SchoolYear { first, second, third, fourth, fifth, sixth, seventh }

extension SchoolYearExtension on SchoolYear {
  int get number {
    switch (this) {
      case SchoolYear.first:
        return 1;
      case SchoolYear.second:
        return 2;
      case SchoolYear.third:
        return 3;
      case SchoolYear.fourth:
        return 4;
      case SchoolYear.fifth:
        return 5;
      case SchoolYear.sixth:
        return 6;
      case SchoolYear.seventh:
        return 7;
    }
  }

  String displayName(BuildContext context) {
    switch (this) {
      case SchoolYear.first:
        return AppLocalizations.of(context)?.translate("first_year") ??
            "First Year";
      case SchoolYear.second:
        return AppLocalizations.of(context)?.translate("second_year") ??
            "Second Year";
      case SchoolYear.third:
        return AppLocalizations.of(context)?.translate("third_year") ??
            "Third Year";
      case SchoolYear.fourth:
        return AppLocalizations.of(context)?.translate("fourth_year") ??
            "Fourth Year";
      case SchoolYear.fifth:
        return AppLocalizations.of(context)?.translate("fifth_year") ??
            "Fifth Year";
      case SchoolYear.sixth:
        return AppLocalizations.of(context)?.translate("sixth_year") ??
            "Sixth Year";
      case SchoolYear.seventh:
        return AppLocalizations.of(context)?.translate("seventh_year") ??
            "Seventh Year";
    }
  }
}
