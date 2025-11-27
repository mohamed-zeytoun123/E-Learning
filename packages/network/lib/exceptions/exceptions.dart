import 'package:network/enums/app_enums.dart';
  import 'package:equatable/equatable.dart';


abstract class ExceptionBase extends Equatable implements Exception {
  final String message;
  final ExceptionCode code;

  const ExceptionBase({
    required this.message,
    required this.code,
  });
}

class ConnectionToInternetException extends ExceptionBase {
  const ConnectionToInternetException(
      {required super.message, required super.code});

  @override
  List<Object?> get props => [message, code];
}

class ApiRequestException extends ExceptionBase {
  const ApiRequestException({required super.message, required super.code});

  @override
  List<Object?> get props => [message, code];
}

class CashException extends ExceptionBase {
  const CashException({required super.message, required super.code});

  @override
  List<Object?> get props => [message, code];
}

class GetLocationException extends ExceptionBase {
  const GetLocationException({required super.message, required super.code});

  @override
  List<Object?> get props => [message, code];
}

class NoPermissionException extends ExceptionBase {
  const NoPermissionException({required super.message, required super.code});

  @override
  List<Object?> get props => [message, code];
}

class MappingToModelException extends ExceptionBase {
  const MappingToModelException({required super.message, required super.code});

  @override
  List<Object?> get props => [message, code];
}

class OTPNotCompletedException extends ExceptionBase {
  const OTPNotCompletedException({required super.message, required super.code});

  @override
  List<Object> get props => [message, code];
}

class UserNotFoundException extends ExceptionBase {
  const UserNotFoundException({required super.message, required super.code});

  @override
  List<Object> get props => [message, code];
}

class WrongDataInRequestException extends ExceptionBase {
  const WrongDataInRequestException(
      {required super.message, required super.code});

  @override
  List<Object> get props => [message, code];
}

class WrongEmailOrPasswordException extends ExceptionBase {
  const WrongEmailOrPasswordException(
      {required super.message, required super.code});

  @override
  List<Object> get props => [message, code];
}

class CanceledByUserException extends ExceptionBase {
  const CanceledByUserException({required super.message, required super.code});

  @override
  List<Object> get props => [message, code];
}

class DownloadingException extends ExceptionBase {
  const DownloadingException({required super.message, required super.code});

  @override
  List<Object> get props => [message, code];
}

class SavingImageToGalleryException extends ExceptionBase {
  const SavingImageToGalleryException(
      {required super.message, required super.code});

  @override
  List<Object> get props => [message, code];
}

class MissingDataException extends ExceptionBase {
  const MissingDataException({required super.message, required super.code});

  @override
  List<Object> get props => [message,code];
}
