import 'dart:async';

import 'package:netwoek/enums/app_enums.dart';
import 'package:netwoek/exceptions/exceptions.dart';
import 'package:netwoek/extensions/exception_extension.dart';
import 'package:netwoek/logger/log.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkConnection {
  Future<bool> hasInternetConnection();

  // Stream<bool> hasInternet();
}

class NetworkConnectionImpl implements NetworkConnection {
  // final Connectivity checker = Connectivity();

  @override
  Future<bool> hasInternetConnection() async {
    try {
      // final hasConnection = await checker.checkConnectivity();
      // Logger.logProcess(
      //     tag: LogTags.internetConnection,
      //     message: hasConnection != ConnectivityResult.none
      //         ? "Has connection to internet"
      //         : "Don't has any connection to internet");
      return true;
    } on Exception catch (e) {
      Logger.logError(e, LogTags.internetConnection);
      throw ConnectionToInternetException(
          message: ExceptionCode.NO_INTERNET.extractMessage,
          code: ExceptionCode.NO_INTERNET);
    }
  }

  // @override
  // Stream<bool> hasInternet() {
  //   return checker.onConnectivityChanged.map((ConnectivityResult event) =>
  //       event != ConnectivityResult.none);
  // }
}
