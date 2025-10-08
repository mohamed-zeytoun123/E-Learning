import 'package:dio/dio.dart';
import 'package:e_learning/core/api/api_consumer.dart';
import 'package:e_learning/core/error/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio});
  @override
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
