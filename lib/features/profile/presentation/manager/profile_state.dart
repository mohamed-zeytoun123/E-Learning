// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/profile/data/model/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/model/user_data_info_model.dart';

class ProfileState {
  final ResponseInfoAppModel privacyPolicyData;
  final Failure? errorFetchPrivacy;
  final bool? isLoadingPrivacy;
  final ResponseInfoAppModel aboutUsData;
  final Failure? errorFetchAboutUs;
  final bool? isLoadingAboutUs;
  final ResponseInfoAppModel termConditionData;
  final Failure? errorFetchTermCondition;
  final bool? isLoadingTermCondition;
  final UserDataInfoModel dataUserInfoProfile;
    final Failure? errorFetchDataUserInfoProfile;
  final bool? isLoadingDataUserProfile;
  ProfileState( {
    required this.privacyPolicyData,
    this.errorFetchPrivacy,
    this.isLoadingPrivacy = false,
    required this.aboutUsData,
    this.errorFetchAboutUs,
    this.isLoadingAboutUs = false,
    required this.termConditionData,
    this.errorFetchTermCondition,
    this.isLoadingTermCondition = false,
    required  this.dataUserInfoProfile,
    this.errorFetchDataUserInfoProfile,
    this.isLoadingDataUserProfile =false,
  });

  ProfileState copyWith({
    ResponseInfoAppModel? privacyPolicyData,
    Failure? errorFetchPrivacy,
    bool? isLoadingPrivacy,
    ResponseInfoAppModel? aboutUsData,
    Failure? errorFetchAboutUs,
    bool? isLoadingAboutUs,
    ResponseInfoAppModel? termConditionData,
    Failure? errorFetchTermCondition,
    bool? isLoadingTermCondition,
    UserDataInfoModel? dataUserInfoProfile,
    Failure? errorFetchDataUserInfoProfile,
    bool? isLoadingDataUserProfile,
  }) {
    return ProfileState(
      privacyPolicyData: privacyPolicyData ?? this.privacyPolicyData,
      errorFetchPrivacy: errorFetchPrivacy,
      isLoadingPrivacy: isLoadingPrivacy ?? false,
      aboutUsData: aboutUsData ?? this.aboutUsData,
      errorFetchAboutUs: errorFetchAboutUs,
      isLoadingAboutUs: isLoadingAboutUs ?? false,
      termConditionData: termConditionData ?? this.termConditionData,
      errorFetchTermCondition: errorFetchTermCondition,
      isLoadingTermCondition: isLoadingTermCondition ?? false,
      dataUserInfoProfile:dataUserInfoProfile ??this.dataUserInfoProfile,
      errorFetchDataUserInfoProfile : errorFetchDataUserInfoProfile,
      isLoadingDataUserProfile : isLoadingDataUserProfile ?? false,
    );
  }
}
