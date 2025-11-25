
extension Validator on String? {
  bool nullValidate() {
    if (this == null) {
      return false;
    } else {
      return true;
    }
  }

  bool get toBool {
    if (this == null) {
      return false;
    } else if (this!.toLowerCase() == "true") {
      return true;
    } else if (this!.toUpperCase() == "false") {
      return false;
    } else {
      return false;
    }
  }

  String get toStringValidate {
    if (this == null || this == "null") {
      return '';
    } else {
      return this!;
    }
  }

  bool emailValidate() {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\])|(([a-zA-Z\-\d]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this ?? '');
  }

  int get toInt {
    if (this == null || this == "null") {
      return 0;
    } else {
      return int.tryParse(this ?? "") ?? 0;
    }
  }

  double get toDouble {
    if (this == null) {
      return 0.0;
    } else {
      return double.tryParse(this!) ?? 0.0;
    }
  }
}
