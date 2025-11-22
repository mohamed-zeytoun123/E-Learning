import 'package:dio/dio.dart';

class ApiRequest {
  final String url;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? body;

  final ResponseType? responseType;

  ApiRequest({
    required this.url,
    this.queryParameters,
    this.body,
    this.responseType,
  });
}
