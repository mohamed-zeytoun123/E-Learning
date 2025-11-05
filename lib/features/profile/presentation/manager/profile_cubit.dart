import 'dart:developer';

import 'package:e_learning/features/profile/data/model/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/model/user_data_info_model.dart';
import 'package:e_learning/features/profile/data/source/repo/profile_repository.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repo)
    : super(
        ProfileState(
          dataUserInfoProfile: UserDataInfoModel(
            id: 1,
            phone: '',
            username: 'User Name',
            fullName: 'user Name',
            universityId: 1,
            universityName: 'university',
            collegeId: 1,
            collegeName: 'collage',
            studyYearId: 1,
            studyYearName: 'study year',
          ),
          aboutUsData: ResponseInfoAppModel(id: 0, title: '', content: ''),
          termConditionData: ResponseInfoAppModel(
            id: 0,
            title: '',
            content: '',
          ),
          privacyPolicyData: ResponseInfoAppModel(
            id: 0,
            title: '',
            content: '',
          ),
        ),
      );
  final ProfileRepository repo;
  void getPrivacyPolicyData() async {
    emit(state.copyWith(isLoadingPrivacy: true));
    var result = await repo.getPrivacyPolicyRepo();
    result.fold(
      (error) {
        log(' 😒error cubit privacy ');
        emit(state.copyWith(errorFetchPrivacy: error));
      },
      (dataResponse) {
        log(' ✅ success cubit privacy ');
        emit(state.copyWith(privacyPolicyData: dataResponse));
      },
    );
  }

  void getAboutUsData() async {
    emit(state.copyWith(isLoadingAboutUs: true));
    var result = await repo.getAboutUsRepo();
    result.fold(
      (error) {
        log(' 😒error cubit About Us ');
        emit(state.copyWith(errorFetchAboutUs: error));
      },
      (data) {
        log(' ✅ success cubit privacy ');
        emit(state.copyWith(aboutUsData: data));
      },
    );
  }

  void getTermsConditionData() async {
    emit(state.copyWith(isLoadingTermCondition: true));
    var result = await repo.getTermsConditionsData();
    result.fold(
      (error) {
        log("error 🔥🔥🔥🔥🔥 term & conditions");
        emit(state.copyWith(errorFetchTermCondition: error));
      },
      (data) {
        log(' ✅ success cubit terms & conditions');
        emit(state.copyWith(termConditionData: data));
      },
    );
  }

  void getDataUserInfoProfile() async {
    // emit(state.copyWith(isLoadingDataUserProfile: true));
    var result = await repo.getDataUserProfileRepo();
    result.fold(
      (error) {
        emit(state.copyWith(errorFetchDataUserInfoProfile: error));
      },
      (dataResponse) {
        emit(state.copyWith(dataUserInfoProfile: dataResponse));
      },
    );
  }
}
