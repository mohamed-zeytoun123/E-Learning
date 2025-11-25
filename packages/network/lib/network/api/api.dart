import 'package:netwoek/durations/duration_manager.dart';
import 'package:netwoek/enums/app_enums.dart';
import 'package:netwoek/extensions/request_type_extesion.dart';
import 'package:netwoek/logger/log.dart';
import 'package:dio/dio.dart';
import 'package:netwoek/network/api/api_request.dart';
import 'package:netwoek/network/api/api_response.dart';

abstract class API {
  final Dio dio;
  API({
    required this.dio,
  });

  Future<ApiResponse> post(ApiRequest request);

  Future<ApiResponse> get(ApiRequest request);

  Future<ApiResponse> put(ApiRequest request);

  Future<ApiResponse> delete(ApiRequest request);

  Future<ApiResponse> uploadMedia(ApiRequest request);
}

class ApiImpl extends API {
  ApiImpl(Dio dio) : super(dio: dio);

  final CancelToken cancelToken = CancelToken();
  final Map<String, CancelToken> _cancelTokens = {};

  @override
  Future<ApiResponse> get(ApiRequest request) async {
    // Create a unique key for the request (e.g., URL and parameters)
    final requestKey = request.url;
    // Check if cancellation is allowed for this request
    if (request.allowCancellation) {
      // Cancel any ongoing request with the same key
      if (_cancelTokens[requestKey]?.isCancelled == false) {
        _cancelTokens[requestKey]?.cancel("Cancelled due to a new request.");
      }
    }

    // Assign a new CancelToken for the current request
    final cancelToken = CancelToken();
    _cancelTokens[requestKey] = cancelToken;

    Logger.logApiRequest(request, RequestType.GET.type);
    final response = await dio.get(request.url,
        queryParameters: request.params,
        options: Options(
          sendTimeout: DurationManager.apiTimeout,
          headers: request.headers,
        ),
        cancelToken: cancelToken // Attach the CancelToken
        );

    final ApiResponse apiResponse = ApiResponse.fromResponse(response);
    Logger.logApiResponse(apiResponse);

    return apiResponse;
  }

  @override
  Future<ApiResponse> post(ApiRequest request) async {
    Logger.logApiRequest(request, RequestType.POST.type);

    final response = await dio.post(
      request.url,
      queryParameters: request.params,
      data: request.body,
      options: Options(
        receiveDataWhenStatusError: true,
        validateStatus: (statue) {
          return true;
        },
        sendTimeout: DurationManager.apiTimeout,
          receiveTimeout: DurationManager.apiReceiveTimeout,
        headers: request.headers,
      ),
    );
    final ApiResponse apiResponse = ApiResponse.fromResponse(response);
    Logger.logApiResponse(apiResponse);

    return apiResponse;
  }

  @override
  Future<ApiResponse> put(ApiRequest request) async {
    Logger.logApiRequest(request, RequestType.PUT.type);
    final response = await dio.put(request.url,
        queryParameters: request.params,
        data: request.body,
        options: Options(
          sendTimeout: DurationManager.apiTimeout,
          headers: request.headers,
        ));
    final ApiResponse apiResponse = ApiResponse.fromResponse(response);
    Logger.logApiResponse(apiResponse);

    return apiResponse;
  }

  @override
  Future<ApiResponse> uploadMedia(ApiRequest request) async {
    final formDataMap = await request.toMultiPart();
    FormData formData = FormData.fromMap(formDataMap);
    Logger.logApiRequest(request, request.media!.requestType.type);

    final Options options = Options(headers: request.headers);
    final Map<String, dynamic>? queryParameters = request.params;

    final Response response = await _sendRequest(
      request.media!.requestType,
      request.url,
      formData,
      options,
      queryParameters,
    );

    final ApiResponse apiResponse = ApiResponse.fromResponse(response);
    Logger.logApiResponse(apiResponse);
    return apiResponse;
  }

  Future<Response> _sendRequest(
    RequestType type,
    String url,
    FormData data,
    Options options,
    Map<String, dynamic>? queryParameters,
  ) async {
    switch (type) {
      case RequestType.GET:
        return await dio.get(url, data: data, options: options);
      case RequestType.PUT:
        return await dio.put(url,
            data: data, queryParameters: queryParameters, options: options);
      case RequestType.POST:
      default:
        return await dio.post(url,
            data: data,
            queryParameters: queryParameters,
            options: options.copyWith(
              followRedirects: false,
              validateStatus: (status) => status! < 500,
            ));
    }
  }

  @override
  Future<ApiResponse> delete(ApiRequest request) async {
    Logger.logApiRequest(
      request,
      RequestType.DELETE.type,
    );
    final response = await dio.delete(request.url,
        queryParameters: request.params,
        options: Options(
          sendTimeout: DurationManager.apiTimeout,
          headers: request.headers,
        ));
    final ApiResponse apiResponse = ApiResponse.fromResponse(response);
    Logger.logApiResponse(apiResponse);

    return apiResponse;
  }
}
