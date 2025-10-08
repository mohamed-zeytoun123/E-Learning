class ApiRequest {
  final String url;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? body;

  ApiRequest({
    required this.url,
    this.queryParameters,
    this.body,
  });
}
