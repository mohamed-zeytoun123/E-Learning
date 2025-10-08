import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppDio {
  late Dio _dio; 

  AppDio() {
    _dio = Dio();
    _initDio();
    _addLoggerToDIo();
  }

  Dio get dio => _dio;

  //?----------------------------------------------------------------------------------------

  _initDio() {
    log('THis is the first step to build Dio without token.');

    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        "Accept": Headers.jsonContentType,
        "Prefer": "return=representation",
        "apikey": "sb_publishable_f5lbKdodkdNG5sqE1sqkNg_eJESDKa3",
        "Content-Type": "application/json",
      },
    );
  }

  //?----------------------------------------------------------------------------------------

  addTokenToHeader(String token) {
    log(' 🔥🔥🔥🔥🔥THis is the last step to build Dio with token $token');
    _dio.options.headers["Authorization"] = 'Bearer $token';
  }
  //?----------------------------------------------------------------------------------------

  Map<String, dynamic> usedHeaderPrivate(Map<String, dynamic> addHeader) {
    final Map<String, dynamic> lastHeader = _dio.options.headers;
    final Map<String, dynamic> newHeader = {
      ...lastHeader,
      ...addHeader,
    };
    return newHeader;
  }

  //?----------------------------------------------------------------------------------------

  _addLoggerToDIo() {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          //* don't  requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          //* don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        }));
  }
  
  //?----------------------------------------------------------------------------------------
}
