import 'package:dio/dio.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';

class API {
  final Dio dio;

  API({
    required this.dio,
  });

  //?--- Get -----------------------------------------------------------
  Future<ApiResponse> get(ApiRequest apiRequest) async {
    try {
      final response = await dio.get(
        apiRequest.url,
        queryParameters: (apiRequest.queryParameters != null &&
                apiRequest.queryParameters!.isNotEmpty)
            ? apiRequest.queryParameters
            : null,
      );
      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  //?--- Post -----------------------------------------------------------
  Future<ApiResponse> post(ApiRequest apiRequest) async {
    try {
      final response = await dio.post(
        apiRequest.url,
        data: apiRequest.body,
      );
      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  //?--- Put -----------------------------------------------------------

  Future<ApiResponse> put(ApiRequest apiRequest) async {
    try {
      final response = await dio.put(
        apiRequest.url,
        data: apiRequest.body,
      );
      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  //?--- Delete -----------------------------------------------------------
  Future<ApiResponse> delete(ApiRequest apiRequest) async {
    try {
      final response = await dio.delete(
        apiRequest.url,
        data: apiRequest.body,
      );
      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  //?--- Patch -----------------------------------------------------------
  Future<ApiResponse> patch(ApiRequest apiRequest) async {
    try {
      final response = await dio.patch(
        apiRequest.url,
        data: apiRequest.body,
      );
      return ApiResponse(
        statusCode: response.statusCode ?? -1,
        body: response.data,
      );
    } catch (e) {
      rethrow;
    }
  }
  //?-----------------------------------------------------------------
}
