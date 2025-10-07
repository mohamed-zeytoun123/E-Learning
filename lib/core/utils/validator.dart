import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:flutter/widgets.dart';

abstract class Validator {
  static String? phoneValidation(String? phone, BuildContext context) {
    final phoneRegex = RegExp(r'^\+[0-9]{9,15}$');
    if (!phoneRegex.hasMatch(phone!)) {
      return AppLocalizations.of(context)?.translate('Phone_is_not_valid') ??
          'Phone is not valid';
    }
    return null;
  }

  static String? emailValidation(String? email, BuildContext context) {
    email = email?.trim();
    bool valid = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email!);

    if (valid) {
      return null;
    } else {
      return AppLocalizations.of(context)?.translate('Email_is_not_valid') ??
          "Email is not valid";
    }
  }

  static String? notNullValidation(String? str, BuildContext context) =>
      (str == null || str == '')
      ? AppLocalizations.of(context)?.translate("This_field_is_required") ??
            'This Filed is required'
      : null;

  static String? notNullValidationValue(String? str) =>
      (str == null || str == '') ? '' : null;

  static String? validatePhone(String? value, BuildContext context) {
    if (value!.isEmpty || value.length < 8) {
      return AppLocalizations.of(context)?.translate("Not_correct") ??
          'not correct';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return AppLocalizations.of(context)?.translate('Please_enter_password') ??
          'Please enter Password';
    } else if (value.length < 8 || value.length > 32) {
      return AppLocalizations.of(context)?.translate('Password_value_range') ??
          'Password value range 8-32 char';
    } else {
      return null;
    }
  }

  static String? validateDateOfBirth(String? value, BuildContext context) {
    RegExp regex = RegExp(
      r"^(19|20)\d\d[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$",
    );
    if (!regex.hasMatch(value!)) {
      return AppLocalizations.of(
            context,
          )?.translate('Date_of_birth_not_valid') ??
          'Date of birth is not valid, please enter YYYY-MM-DD';
    }
    return null;
  }

  static String? validateName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)?.translate('Name_cannot_be_empty') ??
          'Name cannot be empty!';
    } else if (value.length < 3) {
      return AppLocalizations.of(context)?.translate('Name_min_length') ??
          'Name must be at least 3 characters!';
    }
    return null;
  }
}
