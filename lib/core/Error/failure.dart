import 'package:dio/dio.dart';

class Failure {
  final int? statusCode;
  final String message;

  Failure({this.statusCode, required this.message});
  //?----------------------------------------------------------------------------

  //* handele Error
  factory Failure.handleError(Exception exception) {
    if (exception is! DioException) {
      return Failure(statusCode: -1, message: 'An unexpected error occurred');
    }

    final status = exception.response?.statusCode ?? -1;
    final data = exception.response?.data;

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(
          statusCode: status,
          message: 'Connection Timeout, please try again',
        );

      case DioExceptionType.sendTimeout:
        return Failure(
          statusCode: status,
          message: 'Send Timeout, please try again',
        );

      case DioExceptionType.receiveTimeout:
        return Failure(
          statusCode: status,
          message: 'Receive Timeout, please try again',
        );

      case DioExceptionType.badCertificate:
        return Failure(statusCode: status, message: 'Bad SSL Certificate');

      case DioExceptionType.badResponse:
        if (data is Map<String, dynamic>) {
          int? statusCode = data['code'];
          String? errorMsg;
          if (data is Map<String, dynamic> && data.isNotEmpty) {
            String? errorMsg;

            if (data.containsKey('non_field_errors') &&
                data['non_field_errors'] is List &&
                data['non_field_errors'].isNotEmpty) {
              errorMsg = data['non_field_errors'].first.toString();
            } else if (data.containsKey('detail')) {
              errorMsg = data['detail']?.toString();
            } else if (data.containsKey('message')) {
              errorMsg = data['message']?.toString();
            } else {
              final firstValue = data.values.first;
              if (firstValue is String) {
                errorMsg = firstValue;
              } else if (firstValue is List && firstValue.isNotEmpty) {
                errorMsg = firstValue.first.toString();
              } else {
                errorMsg = 'Validation error';
              }
            }

            return Failure(
              statusCode: status,
              message: errorMsg ?? 'Validation error',
            );
          }
          //* if message server is null :
          else {
            switch (status) {
              case 400:
                return Failure(
                  statusCode: status,
                  message: errorMsg ?? 'Invalid request',
                );

              case 401:
                return Failure(
                  statusCode: status,
                  message: 'Unauthorized access, please login again',
                );

              case 404:
                return Failure(
                  statusCode: status,
                  message: 'Resource not found',
                );

              case 422:
                return Failure(
                  statusCode: status,
                  message: errorMsg ?? 'Validation error',
                );

              case 500:
                return Failure(statusCode: status, message: 'Server Error');

              case 403:
                return Failure(
                  statusCode: status,
                  message: 'You don’t have permission to perform this action',
                );

              default:
                return Failure(
                  statusCode: status,
                  message:
                      errorMsg ?? 'Something went wrong, please try again.',
                );
            }
          }
        } else {
          //* لو البيانات مش Map أو فاضي
          return Failure(
            statusCode: status,
            message: 'Unexpected server error',
          );
        }

      case DioExceptionType.cancel:
        return Failure(
          statusCode: status,
          message: 'Request was cancelled by user',
        );

      case DioExceptionType.connectionError:
        return Failure(
          statusCode: status,
          message: 'Connection error, please check your internet',
        );

      case DioExceptionType.unknown:
        return Failure(statusCode: status, message: 'Unknown error occurred');
    }
  }
}

//?-----------------------------------------------------------------------------------
//?--------       Type Failure          ----------------------------------------------
//?-----------------------------------------------------------------------------------

//* Refresh
class FailureRefresh extends Failure {
  FailureRefresh({super.message = 'Refresh failed'});
}

//?-------------------------------------------------

//* Wrong
class FailureWrong extends Failure {
  FailureWrong({super.message = 'An error occurred!'});
}
//?-------------------------------------------------

//* Server
class FailureServer extends Failure {
  FailureServer({super.message = 'Server error!'});
}
//?-------------------------------------------------

//* No Data ( Empty )
class FailureNoData extends Failure {
  FailureNoData({super.message = 'No Data'});
}
//?-------------------------------------------------

//* No Connection
class FailureNoConnection extends Failure {
  FailureNoConnection({super.message = 'No Connection , Pleas Try Agen'});
}
//?-------------------------------------------------

//?-------------------------------------------------
