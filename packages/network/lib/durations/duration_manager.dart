import 'dart:math';

class DurationManager {
  static const int delayBeforeCheckUserName = 500;
  static const int delayBeforeCheckPhoneNumber = 500;

  static const Duration otpTimeout = Duration(seconds: 90);

  static const Duration apiTimeout = Duration(seconds: 15);
  static const Duration apiReceiveTimeout = Duration(seconds: 15);

  static const Duration navigateToAnotherPageTime = Duration(milliseconds: 400);
  static const Duration pushPageAnimation = Duration(milliseconds: 200);

  static const Duration debounceDuration = Duration(milliseconds: 20);

  static const Duration skeletonAnimationDuration = Duration(milliseconds: 600);


  static Duration calculateMessageTime(String? message) =>
      Duration(milliseconds: max((message?.length ?? 20) * 50, 1200));
}
