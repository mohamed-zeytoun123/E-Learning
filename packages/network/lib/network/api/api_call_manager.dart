// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:netwoek/manager_base.dart';
import 'package:netwoek/network.dart';
import 'package:netwoek/network/api/api_response.dart';

abstract class APICallManager {
  Future<Either<Failure, List<T>>> callForListOf<T extends Model>(
      {required Future<ApiResponse> Function() apiMethod,
      required T Function(Map<String, dynamic> fromJSon) fromJSon});
  Future<Either<Failure, T>> callFor<T extends Model>(
      {required Future<ApiResponse> Function() apiMethod,
      required T Function(Map<String, dynamic> fromJSon) fromJSon});
}

class APICallManagerImpl implements APICallManager {
  @override
  Future<Either<Failure, T>> callFor<T extends Model>(
      {required Future<ApiResponse> Function() apiMethod,
      required T Function(Map<String, dynamic> fromJSon) fromJSon}) async {
    try {
      final response = await apiMethod();
      if (response.body!['data'] != null) {
        final dynamic rawData = response.body!['data'];
        final data = Manager.mapper.mapFromJson<T>(rawData, fromJSon);
        return Right(data);
      } else {
        return Left(Failure(message: response.body!['message']));
      }
    } catch (e, stackTrace) {
      return _handleException(e, stackTrace);
    }
  }

  @override
  Future<Either<Failure, List<T>>> callForListOf<T extends Model>(
      {required Future<ApiResponse> Function() apiMethod,
      required T Function(Map<String, dynamic> fromJSon) fromJSon}) async {
    try {
      final response = await apiMethod();

      if (response.body!['data'] != null && response.body!['data'] is List) {
        final dynamic rawData = response.body!['data'];
        final data = Manager.mapper.mapFromList<T>(rawData, fromJSon);
        return Right(data);
      } else {
        return Left(Failure(message: response.body!['message']));
      }
    } catch (e, stackTrace) {
      return _handleException(e, stackTrace);
    }
  }

  Either<Failure, T> _handleException<T>(Object e, StackTrace stackTrace) {
    if (e is DioException) {
      return Left(Failure.fromException(e));
    } else {
      return Left(Failure(message: 'Unknown Error: ${e.toString()}'));
    }
  }
}
