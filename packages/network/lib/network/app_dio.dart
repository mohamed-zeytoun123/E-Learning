import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppDio {
  static late Dio dio;

  AppDio() {
    dio = Dio();
    initDio();
    addLogger();
  }

  Dio get instance => dio;

  initDio() {
    dio.options.headers = {
      "Accept": "application/json",
    };
    addTokenToHeader(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoyNjY0MjY2NzU4LCJpYXQiOjE3NjQyNjY3NTgsImp0aSI6IjdmODUwMWJmYmE1MDQ2MDZhZDMwYWU5OGE4YjMyOTQwIiwidXNlcl9pZCI6IjM1Iiwicm9sZSI6IlNUVURFTlQifQ.FnV_4zEBih0Y8Xf1GBX_9TLEKVsIJw8SMBTdmmJIhwQ");
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
