import 'package:network/enums/app_enums.dart';
import 'package:network/exceptions/exceptions.dart';
import 'package:network/failures/failures.dart';
import 'package:network/logger/log.dart';
import 'package:dio/dio.dart';

extension ExceptionToFailure on Exception {
  Failure toFailure([String errorLocation = LogTags.unknown]) {
    final temp = this;
    if (temp is ExceptionBase) {
      Logger.logError(temp.message, errorLocation);
      return Failure(
        errorCode: temp.code.extractCode,
        message: temp.message,
      );
    } else if (temp is DioException) {
      return Failure(
          message: temp.message ?? ExceptionCode.HTTP.extractMessage,
          errorCode: ExceptionCode.HTTP.extractCode);
    } else {
      Logger.logError(toString(), errorLocation);
      return Failure(
          message: "Exception",
          // ? kTranslationsMap[instance<AppManagerBloc>().isLocalArabic] ??
          // {}["unknown"] ??
          // 'unknown'
          //  : toString(),
          errorCode: ExceptionCode.UNKNOWN.extractCode);
    }
  }
}

extension ExceptionCodeEx on ExceptionCode {
  int get extractCode {
    switch (this) {
      case ExceptionCode.PHONE_ALREADY_TAKEN:
        return 9;
      case ExceptionCode.WRONG_EMAIL_PASSWORD:
        return 8;
      case ExceptionCode.CANCELED_BY_USER:
        return 7;
      case ExceptionCode.FIREBASE:
        return 6;
      case ExceptionCode.NO_INTERNET:
        return 5;
      case ExceptionCode.OTPNOTCOMPLETED:
        return 4;
      case ExceptionCode.MISSING_MEDIA:
        return 3;
      case ExceptionCode.UNKNOWN:
        return 0;
      case ExceptionCode.CASH:
        return 1;
      case ExceptionCode.HTTP:
        return 2;
      default:
        return 0;
    }
  }

  String get extractMessage {
    final Map translationMap = {};
    // kTranslationsMap[instance<AppManagerBloc>().isLocalArabic] ?? {};
    switch (this) {
      case ExceptionCode.PHONE_ALREADY_TAKEN:
        return translationMap['phone_already_taken'] ?? "Phone number is taken";
      case ExceptionCode.MISIING_DATA:
        return translationMap[
                "you_need_to_choose_to_choose_some_thing_first"] ??
            "You need to choose some thing first.";
      case ExceptionCode.SAVING_IMAGE_TO_GALLERY:
        return translationMap['saving_image_error'] ??
            "Can't save this image to gallery.";
      case ExceptionCode.DOWNLOADING:
        return translationMap['error_in_downloading'] ??
            "Can't download image duo to some error.";
      case ExceptionCode.WRONG_EMAIL_PASSWORD:
        return translationMap['wrong_email_password'] ??
            "username / password is incorrect.";
      case ExceptionCode.CANCELED_BY_USER:
        return translationMap['canceled_by_user'] ??
            "The process is canceled by user.";
      case ExceptionCode.WRONG_DATA:
        return translationMap['wrong_data'] ??
            "The data is missing or have some problem.";
      case ExceptionCode.USER_NOT_FOUND:
        return translationMap['user_not_found'] ?? "User not found";
      case ExceptionCode.OTPNOTCOMPLETED:
        return translationMap['otp_not_completed'] ??
            "Your OTP process need to be completed.";
      case ExceptionCode.MAPPING:
        return translationMap['error_in_mapping'] ?? "Error in converting data";
      case ExceptionCode.LOCATION_ACCESS:
        return translationMap["cant_access_location"] ?? "";
      case ExceptionCode.MISSING_MEDIA:
        return translationMap["you_missing_media"] ?? "You are missing media";
      case ExceptionCode.CASH:
        return "";
      case ExceptionCode.HTTP:
        return translationMap["failed_in_send_request"] ??
            "Failed in sending request.. please try again later.";
      case ExceptionCode.NO_INTERNET:
        return translationMap['no_internet_connection'] ??
            "No internet connection";
      case ExceptionCode.UNKNOWN:
      default:
        return translationMap['unknown'] ?? "Unknown";
    }
  }
}
