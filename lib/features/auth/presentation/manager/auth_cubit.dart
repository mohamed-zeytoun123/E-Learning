import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/data/models/params/reset_password_request_params.dart';
import 'package:e_learning/features/auth/data/models/university_model.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit({required this.repository}) : super(AuthState());

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
    String? phone,
    String? password,
  }) {
    final currentParams =
        state.signUpRequestParams ??
        SignUpRequestParams(
          fullName: '',
          universityId: null,
          collegeId: null,
          studyYear: null,
          phone: '',
          password: '',
        );

    final updatedParams = SignUpRequestParams(
      fullName: fullName ?? currentParams.fullName,
      universityId: universityId ?? currentParams.universityId,
      collegeId: collegeId,
      studyYear: studyYear ?? currentParams.studyYear,
      phone: phone ?? currentParams.phone,
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
        .otpVerficationRepo(phone: phone, code: code, purpose: purpose)
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

  //?---------------------------------------------------------------------------------------
}
