import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


extension OrTrue on bool? {
  bool get orTrue => this ?? true;
  bool get orFalse => this ?? false;
}

extension OnString on String? {
  String get orEmpty => this ?? "";
  String get firstLetter =>
      this?.isNotEmpty == true ? this![0].toUpperCase() : "";
}

// extension FormDataExtension on FormData {
//   stringify() {
//     final body = {};
//     for (var element in fields) {
//       body.addAll({element.key: element.value});
//     }
//     for (var element in files) {
//       body.addAll({element.key: element.value});
//     }
//     pr(body);
//     return body;
//   }
// }

extension FromJson on Map<String, dynamic> {
  int integer(String key) => (this[key] is int) ? this[key] : 0;
  num number(String key) => (this[key] is num) ? this[key] : 0;
  num? numberNullable(String key) => this[key] == null
      ? null
      : (this[key] is num)
          ? this[key]
          : 0;

  String string(String key) => (this[key] is String) ? this[key] : "";

  Map<String, dynamic> mapper(String key) =>
      (this[key] is Map<String, dynamic>) ? this[key] : {};

  List list(String key) => (this[key] is List) ? this[key] : [];
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}

extension ColorEx on Color {
  WidgetStateProperty<Color?> get materialColor =>
      MaterialStateProperty.all(this);
}


// extension OrderEx on OrderStatus {
//   int getValue() {
//     switch (this) {
//       case OrderStatus.PENDING:

//         return 1;
//       case OrderStatus.ACCEPTED:
//         return 2;
//       case OrderStatus.CANCELED:
//         return 3;
//       case OrderStatus.COMPLETED:
//         return 4;
//       case OrderStatus.IN_PROGRESS:
//         return 6;
//     }
//   }
  
// }

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
