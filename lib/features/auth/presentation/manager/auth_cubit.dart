import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/params/reset_password_request_params.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  Timer? _otpTimer;

  AuthCubit({required this.repository}) : super(AuthState());

  @override
  Future<void> close() {
    _otpTimer?.cancel();
    return super.close();
  }

  //? ------------------------ Login ----------------------------
  Future<void> login(String numberPhone, String password) async {
    emit(
      state.copyWith(loginState: ResponseStatusEnum.loading, loginError: null),
    );

    final result = await repository.loginRepo(numberPhone, password);

    result.fold(
      (failure) => emit(
        state.copyWith(
          loginState: ResponseStatusEnum.failure,
          loginError: failure.message,
        ),
      ),
      (userData) {
        emit(
          state.copyWith(
            loginState: ResponseStatusEnum.success,
            loginError: null,
            user: userData,
          ),
        );
      },
    );
  }

  //? ------------------------ SignUp ----------------------------
  Future<void> signUp({required SignUpRequestParams params}) async {
    emit(
      state.copyWith(
        signUpState: ResponseStatusEnum.loading,
        signUpError: null,
      ),
    );

    final result = await repository.signUpRepo(params: params);

    result.fold(
      (failure) => emit(
        state.copyWith(
          signUpState: ResponseStatusEnum.failure,
          signUpError: failure.message,
        ),
      ),
      (userData) {
        emit(
          state.copyWith(
            signUpState: ResponseStatusEnum.success,
            signUpError: null,
          ),
        );
      },
    );
  }

  //? ------------------------ Get Universities ----------------------------
  Future<void> getUniversities() async {
    emit(
      state.copyWith(
        getUniversitiesState: ResponseStatusEnum.loading,
        getUniversitiesError: null,
      ),
    );

    final Either<Failure, List<UniversityModel>> result = await repository
        .getUniversitiesRepo();

    result.fold(
      (failure) => emit(
        state.copyWith(
          getUniversitiesState: ResponseStatusEnum.failure,
          getUniversitiesError: failure.message,
        ),
      ),
      (universitiesList) => emit(
        state.copyWith(
          getUniversitiesState: ResponseStatusEnum.success,
          universities: universitiesList,
        ),
      ),
    );
  }

  //? ------------------------  Get Colleges ---------------------------------

  Future<void> getColleges({required int universityId}) async {
    emit(state.copyWith(getCollegesState: ResponseStatusEnum.loading));

    final result = await repository.getCollegesRepo(universityId: universityId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            getCollegesState: ResponseStatusEnum.failure,
            getCollegesError: failure.message,
          ),
        );
      },
      (collegesList) {
        emit(
          state.copyWith(
            getCollegesState: ResponseStatusEnum.success,
            colleges: collegesList,
          ),
        );
      },
    );
  }

  //? ------------------------ Update SignUp Params (with emit) ----------------------------
  void updateSignUpParams({
    String? fullName,
    int? universityId,
    int? collegeId,
    int? studyYear,
    String? email,
    String? password,
  }) {
    final currentParams =
        state.signUpRequestParams ??
        SignUpRequestParams(
          fullName: '',
          universityId: null,
          collegeId: null,
          studyYear: null,
          email: '',
          password: '',
        );

    final updatedParams = SignUpRequestParams(
      fullName: fullName ?? currentParams.fullName,
      universityId: universityId ?? currentParams.universityId,
      collegeId: collegeId, // Fixed: Always use the passed value, even if null
      studyYear: studyYear ?? currentParams.studyYear,
      email: email ?? currentParams.email,
      password: password ?? currentParams.password,
    );

    emit(state.copyWith(signUpRequestParams: updatedParams));
  }

  //? ------------------------ otp verfication ----------------------------
  Future<void> otpVerfication(String phone, String code, String purpose) {
    emit(
      state.copyWith(
        otpVerficationState: ResponseStatusEnum.loading,
        otpVerficationError: null,
      ),
    );
    return repository
        .otpVerficationRepo(email: phone, code: code, purpose: purpose)
        .then((result) {
          result.fold(
            (failure) => emit(
              state.copyWith(
                otpVerficationState: ResponseStatusEnum.failure,
                otpVerficationError: failure.message,
              ),
            ),
            (otpResponse) {
              emit(
                state.copyWith(
                  otpVerficationState: ResponseStatusEnum.success,
                  otpVerficationError: null,
                  resetToken: otpResponse.resetToken, // Store the reset token
                ),
              );
            },
          );
        });
  }

  //? ------------------------ OTP Timer Management ----------------------------
  void startOtpTimer() {
    _otpTimer?.cancel();
    emit(state.copyWith(otpTimerSeconds: 60, canResendOtp: false));

    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.otpTimerSeconds > 0) {
        emit(state.copyWith(otpTimerSeconds: state.otpTimerSeconds - 1));
      } else {
        emit(state.copyWith(canResendOtp: true));
        timer.cancel();
      }
    });
  }

  void stopOtpTimer() {
    _otpTimer?.cancel();
  }

  void setOtpCode(String code) {
    emit(state.copyWith(currentOtpCode: code));
  }

  // ------------------------- Resend OTP ----------------------------
  Future<void> resendOtp(String phone, String purpose) async {
    // Check if resend is allowed (timer expired)
    if (!state.canResendOtp) {
      return;
    }

    emit(
      state.copyWith(
        resendOtpState: ResponseStatusEnum.loading,
        resendOtpError: null,
      ),
    );

    final result = await repository.resendOtpRepo(
      email: phone,
      purpose: purpose,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          resendOtpState: ResponseStatusEnum.failure,
          resendOtpError: failure.message,
        ),
      ),
      (isResent) {
        emit(
          state.copyWith(
            resendOtpState: ResponseStatusEnum.success,
            resendOtpError: null,
          ),
        );
        // Restart the timer after successful resend
        startOtpTimer();
      },
    );
  }

  //? ------------------------ Forgot Password ----------------------------
  Future<void> forgotPassword(String phone) {
    emit(
      state.copyWith(
        forgotPasswordState: ResponseStatusEnum.loading,
        forgotPasswordError: null,
      ),
    );
    return repository.forgetPasswordRepo(phone: phone).then((result) {
      result.fold(
        (failure) => emit(
          state.copyWith(
            forgotPasswordState: ResponseStatusEnum.failure,
            forgotPasswordError: failure.message,
          ),
        ),
        (userData) {
          emit(
            state.copyWith(
              forgotPasswordState: ResponseStatusEnum.success,
              forgotPasswordError: null,
            ),
          );
        },
      );
    });
  }

  //? ------------------------ Reset Password ----------------------------
  Future<void> resetPassword(ResetPasswordRequestParams params) {
    emit(
      state.copyWith(
        resetPasswordState: ResponseStatusEnum.loading,
        resetPasswordError: null,
      ),
    );
    return repository.resetPasswordRepo(params: params).then((result) {
      result.fold(
        (failure) => emit(
          state.copyWith(
            resetPasswordState: ResponseStatusEnum.failure,
            resetPasswordError: failure.message,
          ),
        ),
        (isReset) {
          emit(
            state.copyWith(
              resetPasswordState: ResponseStatusEnum.success,
              resetPasswordError: null,
            ),
          );
        },
      );
    });
  }

  //? ------------------------ Get Study Years ----------------------------

  Future<void> getStudyYears() async {
    emit(
      state.copyWith(
        getStudyYearsState: ResponseStatusEnum.loading,
        studyYearsError: null,
      ),
    );

    final result = await repository.getStudyYearsRepo();

    result.fold(
      (failure) => emit(
        state.copyWith(
          getStudyYearsState: ResponseStatusEnum.failure,
          studyYearsError: failure.message,
        ),
      ),
      (studyYearsList) => emit(
        state.copyWith(
          getStudyYearsState: ResponseStatusEnum.success,
          studyYears: studyYearsList,
        ),
      ),
    );
  }

  //?---------------------------------------------------------------------------------------
}
