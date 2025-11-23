import 'package:dio/dio.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';

class API {
  final Dio dio;

  API({required this.dio});

  // ------------------- GET -------------------
  Future<ApiResponse> get(ApiRequest apiRequest) async {
    try {
      print('🌐 Making GET request to: ${apiRequest.url}');
      if (apiRequest.queryParameters != null && apiRequest.queryParameters!.isNotEmpty) {
        print('📋 Query parameters: ${apiRequest.queryParameters}');
      }
      final response = await dio.get(
        apiRequest.url,
        queryParameters: (apiRequest.queryParameters != null &&
                apiRequest.queryParameters!.isNotEmpty)
            ? apiRequest.queryParameters
            : null,
      );
      print('✅ Response status: ${response.statusCode}');
      print('📦 Response data type: ${response.data.runtimeType}');
      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      print('❌ GET request failed for ${apiRequest.url}');
      print('❌ Error: $e');
      if (e is DioException) {
        print('❌ DioException type: ${e.type}');
        print('❌ Response status: ${e.response?.statusCode}');
        print('❌ Response data: ${e.response?.data}');
        print('❌ Error message: ${e.message}');
      }
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
