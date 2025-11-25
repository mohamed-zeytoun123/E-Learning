import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? phoneValidation(String? phone) {
    final phoneRegex = RegExp(r'^\+[0-9]{9,15}$');
    if (!phoneRegex.hasMatch(phone!)) {
      return 'Phone_is_not_valid'.tr();
    }
    return null;
  }

  static String? emailValidation(String? email) {
    email = email?.trim();
    bool valid = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email!);

    if (valid) {
      return null;
    } else {
      return 'Email_is_not_valid'.tr();
    }
  }

  static String? notNullValidation(String? str) =>
      (str == null || str == '') ? 'This_field_is_required'.tr() : null;

  static String? notNullValidationValue(String? str) =>
      (str == null || str == '') ? '' : null;

  static String? validatePhone(String? value) {
    if (value!.isEmpty || value.length < 8) {
      return 'Not_correct'.tr();
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please_enter_password'.tr();
    } else if (value.length < 8 || value.length > 32) {
      return 'Password_value_range'.tr();
    } else {
      return null;
    }
  }

  static String? validateDateOfBirth(String? value) {
    RegExp regex = RegExp(
      r"^(19|20)\d\d[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$",
    );
    if (!regex.hasMatch(value!)) {
      return 'Date_of_birth_not_valid'.tr();
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name_cannot_be_empty'.tr();
    } else if (value.length < 3) {
      return 'Name_min_length'.tr();
    }
    return null;
  }
}
