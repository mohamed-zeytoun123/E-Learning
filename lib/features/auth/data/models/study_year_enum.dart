import 'package:easy_localization/easy_localization.dart';
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
        return "study_years.first_year".tr();
      case SchoolYear.second:
        return "study_years.second_year".tr();
      case SchoolYear.third:
        return "study_years.third_year".tr();
      case SchoolYear.fourth:
        return "study_years.fourth_year".tr();
      case SchoolYear.fifth:
        return "study_years.fifth_year".tr();
      case SchoolYear.sixth:
        return "study_years.sixth_year".tr();
      case SchoolYear.seventh:
        return "study_years.seventh_year".tr();
    }
  }
}
