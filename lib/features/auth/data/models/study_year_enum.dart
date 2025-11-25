import 'package:easy_localization/easy_localization.dart';

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

  String displayName() {
    switch (this) {
      case SchoolYear.first:
        return "first_year".tr();
      case SchoolYear.second:
        return "second_year".tr();
      case SchoolYear.third:
        return "third_year".tr();
      case SchoolYear.fourth:
        return "fourth_year".tr();
      case SchoolYear.fifth:
        return "fifth_year".tr();
      case SchoolYear.sixth:
        return "sixth_year".tr();
      case SchoolYear.seventh:
        return "seventh_year".tr();
    }
  }
}
