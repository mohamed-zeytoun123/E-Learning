// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';

class AuthState {
  //?--------------------------------------------------------------
  //* LogIn
  final ResponseStatusEnum loginState;
  final String? loginError;

  //* Sign Up
  final ResponseStatusEnum signUpState;
  final String? signUpError;

  //?--------------------------------------------------------------

  AuthState({
    this.loginState = ResponseStatusEnum.initial,
    this.loginError,
    this.signUpState = ResponseStatusEnum.initial,
    this.signUpError,
  });

  AuthState copyWith({
    ResponseStatusEnum? loginState,
    String? loginError,
    ResponseStatusEnum? signUpState,
    String? signUpError,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      loginError: loginError,
      signUpState: signUpState ?? this.signUpState,
      signUpError: signUpError,
    );
  }
}
