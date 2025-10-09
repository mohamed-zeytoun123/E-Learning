import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/model/enums/app_role_enum.dart';
import 'package:e_learning/core/model/response_model/auth_response_model.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/auth/data/source/local/auth_local_data_source.dart';
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
  Future<void> signUp({
    required String fullName,
    required int universityId,
    required int collegeId,
    required int studyYear,
    required String phone,
    required String password,
  }) async {
    emit(
      state.copyWith(
        signUpState: ResponseStatusEnum.loading,
        signUpError: null,
      ),
    );

    final result = await repository.signUpRepo(
      fullName: fullName,
      universityId: universityId,
      collegeId: collegeId,
      studyYear: studyYear,
      phone: phone,
      password: password,
    );

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
}
