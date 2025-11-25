import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int? errorCode;

  const Failure({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];

  factory Failure.fromException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(message: 'Internet error');
      case DioExceptionType.sendTimeout:
        return Failure(message: 'Internet error');
      case DioExceptionType.receiveTimeout:
        return Failure(message: 'Internet error');
      case DioExceptionType.badCertificate:
        return Failure(message: 'Internet error');

      case DioExceptionType.badResponse:
        final response = e.response;
        if (response != null && response.statusCode != null) {
          final statusCode = response.statusCode!;
          final data = response.data;
          if (data is Map) {
            // Check for different error message keys
            if (data.containsKey('detail')) {
              return Failure(message: data['detail'].toString());
            } else if (data.containsKey('message')) {
              return Failure(message: data['message'].toString());
            } else if (data.containsKey('error')) {
              return Failure(message: data['error'].toString());
            } else if (data.containsKey('errors')) {
              return Failure(message: data['errors'].toString());
            }
          }
          if (statusCode > 400 && statusCode < 500) {
            return Failure(message: 'Error happened, Try again');
          } else if (statusCode >= 500) {
            return Failure(message: 'Server error, Try again');
          }
        }
        return Failure(message: 'Error happened, Try again');

      case DioExceptionType.cancel:
        return Failure(message: 'Error by user cancellation');
      case DioExceptionType.connectionError:
        return Failure(message: 'Check Your Internet');
      case DioExceptionType.unknown:
        return Failure(message: 'Error happened, Try again');
    }
  }
}
