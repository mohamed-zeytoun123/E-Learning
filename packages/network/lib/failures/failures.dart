import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final int? errorCode;

  const Failure({
    required this.message,
    this.statusCode,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, statusCode, errorCode];

  static Failure handleError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const FailureNoConnection();
      case DioExceptionType.badCertificate:
        return const FailureServer(message: 'Certificate error');
      case DioExceptionType.cancel:
        return Failure(message: exception.message ?? 'Request cancelled');
      case DioExceptionType.badResponse:
        final response = exception.response;
        final message = _extractMessage(response?.data) ??
            exception.message ??
            'Error happened, try again';
        return Failure(
          message: message,
          statusCode: response?.statusCode,
        );
      case DioExceptionType.unknown:
        return Failure(message: exception.message ?? 'Unknown error');
    }
  }

  factory Failure.fromException(DioException exception) {
    return handleError(exception);
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map) {
      for (final key in ['message', 'detail', 'error', 'errors']) {
        if (data[key] != null) return data[key].toString();
      }
    }
    if (data is List && data.isNotEmpty) {
      return data.first.toString();
    }
    if (data != null) {
      return data.toString();
    }
    return null;
  }
}

class FailureServer extends Failure {
  const FailureServer({
    String message = 'Server error, try again later',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

class FailureNoConnection extends Failure {
  const FailureNoConnection({
    String message = 'Check your internet connection',
  }) : super(message: message);
}

class FailureNoData extends Failure {
  const FailureNoData({
    String message = 'No data available',
  }) : super(message: message);
}
