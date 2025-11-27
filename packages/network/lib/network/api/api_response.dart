import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:network/enums/app_enums.dart';
import 'package:network/extensions/exception_extension.dart';

class ApiResponse {
  final Map? body;
  final int statusCode;
  final String url;
  const ApiResponse({
    this.body,
    required this.statusCode,
    required this.url,
  });

  bool get success => statusCode == 200;
  dynamic get data => body?['data'];

  String get message {
    if (body is Map) {
      final bodyMap = body as Map;
      if (bodyMap.containsKey('detail')) {
        return bodyMap['detail'].toString();
      } else if (bodyMap.containsKey('message')) {
        return bodyMap['message'].toString();
      } else if (bodyMap.containsKey('error')) {
        return bodyMap['error'].toString();
      } else if (bodyMap.containsKey('errors')) {
        return bodyMap['errors'].toString();
      }
    }
    return ExceptionCode.UNKNOWN.extractMessage;
  }

  factory ApiResponse.fromResponse(Response response) {
    String bodyString = jsonEncode(response.data);
    var decodedBody = jsonDecode(bodyString);
    final Map body = decodedBody is Map ? decodedBody : {};
    return ApiResponse(
        statusCode: response.statusCode ?? 0,
        body: body,
        url: response.requestOptions.uri.path);
  }

  @override
  String toString() {
    return 'ApiResponse{body: $body, statusCode: $statusCode}';
  }
}
