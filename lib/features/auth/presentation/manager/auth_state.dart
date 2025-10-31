// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/auth/data/models/college_model/college_model.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';

class AuthState {
  //?--------------------------------------------------------------
  //* LogIn
  final ResponseStatusEnum loginState;
  final String? loginError;

  //* Sign Up
  final ResponseStatusEnum signUpState;
  final String? signUpError;
  final SignUpRequestParams? signUpRequestParams;

  //* Get University
  final ResponseStatusEnum getUniversitiesState;
  final String? getUniversitiesError;
  final List<UniversityModel> universities;

  //* Get Colleges
  final ResponseStatusEnum getCollegesState;
  final String? getCollegesError;
  final List<CollegeModel> colleges;

  //* otp verfication
  final ResponseStatusEnum otpVerficationState;
  final String? otpVerficationError;
  final String? resetToken; // Store the reset token from OTP verification

  //* Forgot Password
  final ResponseStatusEnum forgotPasswordState;
  final String? forgotPasswordError;

  //* Reset Password
  final ResponseStatusEnum resetPasswordState;
  final String? resetPasswordError;

  //?--------------------------------------------------------------

  AuthState({
    this.signUpRequestParams,
    this.loginState = ResponseStatusEnum.initial,
    this.loginError,
    this.signUpState = ResponseStatusEnum.initial,
    this.signUpError,
    this.getUniversitiesState = ResponseStatusEnum.initial,
    this.getUniversitiesError,
    this.universities = const [],
    this.getCollegesState = ResponseStatusEnum.initial,
    this.getCollegesError,
    this.colleges = const [],
    this.otpVerficationState = ResponseStatusEnum.initial,
    this.otpVerficationError,
    this.resetToken,
    this.forgotPasswordState = ResponseStatusEnum.initial,
    this.forgotPasswordError,
    this.resetPasswordState = ResponseStatusEnum.initial,
    this.resetPasswordError,
  });

  AuthState copyWith({
    SignUpRequestParams? signUpRequestParams,
    ResponseStatusEnum? loginState,
    String? loginError,
    ResponseStatusEnum? signUpState,
    String? signUpError,
    ResponseStatusEnum? getUniversitiesState,
    String? getUniversitiesError,
    List<UniversityModel>? universities,
    ResponseStatusEnum? getCollegesState,
    String? getCollegesError,
    List<CollegeModel>? colleges,
    ResponseStatusEnum? otpVerficationState,
    String? otpVerficationError,
    String? resetToken,
    ResponseStatusEnum? forgotPasswordState,
    String? forgotPasswordError,
    ResponseStatusEnum? resetPasswordState,
    String? resetPasswordError,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      signUpRequestParams: signUpRequestParams ?? this.signUpRequestParams,
      loginError: loginError,
      signUpState: signUpState ?? this.signUpState,
      signUpError: signUpError,
      getUniversitiesState: getUniversitiesState ?? this.getUniversitiesState,
      getUniversitiesError: getUniversitiesError,
      universities: universities ?? this.universities,
      getCollegesState: getCollegesState ?? this.getCollegesState,
      getCollegesError: getCollegesError,
      colleges: colleges ?? this.colleges,
      otpVerficationState: otpVerficationState ?? this.otpVerficationState,
      otpVerficationError: otpVerficationError,
      resetToken: resetToken ?? this.resetToken,
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
      forgotPasswordError: forgotPasswordError,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      resetPasswordError: resetPasswordError,
    );
  }
}
