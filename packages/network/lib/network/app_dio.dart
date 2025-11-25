import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class AppDio {
  static late Dio dio;

  AppDio() {
    dio = Dio();
    initDio();
  //  addLogger();
  }

  Dio get instance => dio;

  initDio() {
    dio.options.headers = {
      "Accept": "application/json",
    };
  }

  addFieldToHeader(Map<String, dynamic> data) {
    dio.options.headers.addAll(data);
  }

  addTokenToHeader(String userToken) {
    log('save to token');

    
    dio.options.headers.addAll({
      'Authorization': 'Bearer $userToken',
    });
  }

  addLogger() {
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        }));
  }
}
