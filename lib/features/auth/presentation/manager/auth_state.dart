// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/auth/data/models/college_model.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';

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
    );
  }
}
