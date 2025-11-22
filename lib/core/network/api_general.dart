import 'package:dio/dio.dart';
import 'api_request.dart';
import 'api_response.dart';

class API {
  final Dio dio;

  API({required this.dio});

  // ------------------- GET -------------------
  Future<ApiResponse> get(ApiRequest apiRequest) async {
    try {
      final response = await dio.get(
        apiRequest.url,
        queryParameters: apiRequest.queryParameters,
        options: Options(
          responseType: apiRequest.responseType ?? ResponseType.json,
        ),
      );

      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  // ------------------- POST -------------------
  Future<ApiResponse> post(ApiRequest apiRequest) async {
    try {
      final response = await dio.post(
        apiRequest.url,
        queryParameters: apiRequest.queryParameters,
        data: apiRequest.body,
        options: Options(
          responseType: apiRequest.responseType ?? ResponseType.json,
        ),
      );

      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  // ------------------- PUT -------------------
  Future<ApiResponse> put(ApiRequest apiRequest) async {
    try {
      final response = await dio.put(
        apiRequest.url,
        queryParameters: apiRequest.queryParameters,
        data: apiRequest.body,
        options: Options(
          responseType: apiRequest.responseType ?? ResponseType.json,
        ),
      );

      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  // ------------------- DELETE -------------------
  Future<ApiResponse> delete(ApiRequest apiRequest) async {
    try {
      final response = await dio.delete(
        apiRequest.url,
        queryParameters: apiRequest.queryParameters,
        data: apiRequest.body,
        options: Options(
          responseType: apiRequest.responseType ?? ResponseType.json,
        ),
      );

      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  // ------------------- PATCH -------------------
  Future<ApiResponse> patch(ApiRequest apiRequest) async {
    try {
      final response = await dio.patch(
        apiRequest.url,
        queryParameters: apiRequest.queryParameters,
        data: apiRequest.body,
        options: Options(
          responseType: apiRequest.responseType ?? ResponseType.json,
        ),
      );

      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
