import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/core/services/token/token_service.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppDio {
  final TokenService tokenService;

  late Dio _dio;

  AppDio({required this.tokenService}) {
    _dio = Dio();
    _initDio();
    _addLoggerToDIo();
    _addTokenInterceptor();
    addTokenToHeader(
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYxODY1ODc1LCJpYXQiOjE3NjE4NjQ5NzUsImp0aSI6IjNmMmYxNDU1ODNjODRmMzY4NTY3ODJlMzMxMDkxYWQyIiwidXNlcl9pZCI6IjIiLCJyb2xlIjoiU1RVREVOVCJ9.V9--y6ikSp_IjibJ1t5_wlJ85jC2WcV0WY_DCreRHXc",
    );
  }

  Dio get dio => _dio;

  //?----------------------------------------------------------------------------------------
  void _initDio() {
    log('Building Dio instance without token.');
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
      contentType: Headers.jsonContentType,
      headers: {
        "Accept": Headers.jsonContentType,
        "Prefer": "return=representation",
        "apikey": "sb_publishable_f5lbKdodkdNG5sqE1sqkNg_eJESDKa3",
        "Content-Type": "application/json",
        "Accept-Language": "en",
      },
    );
  }

  //?----------------------------------------------------------------------------------------
  void addTokenToHeader(String token) {
    log('🔥 Added token to Dio headers: $token');
    _dio.options.headers["Authorization"] = 'Bearer $token';
  }

  //?----------------------------------------------------------------------------------------
  Map<String, dynamic> usedHeaderPrivate(Map<String, dynamic> addHeader) {
    final Map<String, dynamic> lastHeader = _dio.options.headers;
    final Map<String, dynamic> newHeader = {...lastHeader, ...addHeader};
    return newHeader;
  }

  //?----------------------------------------------------------------------------------------
  void _addLoggerToDIo() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          if (options.path.contains('/posts')) return false;
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }

  //?----------------------------------------------------------------------------------------
  void _addTokenInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final hasToken = await tokenService.hasTokenService();

          if (hasToken) {
            final token = await tokenService.getTokenService();
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onError: (DioException err, handler) async {
          if (err.response?.statusCode == 401) {
            final refreshToken = await tokenService.getRefreshTokenService();
            final newAccessToken = await _refreshAccessToken(refreshToken);

            if (newAccessToken.isNotEmpty) {
              // خزّن التوكن الجديد
              await tokenService.saveTokenService(newAccessToken);

              err.requestOptions.headers["Authorization"] =
                  "Bearer $newAccessToken";
              final cloneReq = await _dio.fetch(err.requestOptions);
              return handler.resolve(cloneReq);
            } else {
              await tokenService.clearTokenService();
              return handler.reject(
                DioException(
                  requestOptions: err.requestOptions,
                  error: 'Session expired. Please login again.',
                  type: DioExceptionType.unknown,
                ),
              );
            }
          }
          return handler.next(err);
        },
      ),
    );
  }

  //?----------------------------------------------------------------------------------------
  Future<String> _refreshAccessToken(String? refreshToken) async {
    if (refreshToken == null || refreshToken.isEmpty) {
      return '';
    }

    try {
      final response = await _dio.post(
        AppUrls.refreashToken,
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        // ملاحظة: تأكد من اسم الحقل يلي بيرجعه الباك إند
        final newAccessToken = response.data['access'] as String;

        // خزّن التوكن الجديد
        await tokenService.saveTokenService(newAccessToken);

        return newAccessToken;
      }
    } catch (e) {
      log('Error refreshing token: $e');
    }

    return '';
  }

  //?----------------------------------------------------------------------------------------
}
