// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/profile/data/model/data_course_saved_model.dart';
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
  final int? counter;
  final bool? isLoadingMore;
   final DataResponseSaveCoursesPagination dataSavedcourses;
  final Failure? errorFetchdataSavedcourses;
  final bool? isLoadingdataSavedcourses;
  ProfileState({
    required this.privacyPolicyData,
    this.errorFetchPrivacy,
    this.isLoadingPrivacy = false,
    required this.aboutUsData,
    this.errorFetchAboutUs,
    this.isLoadingAboutUs = false,
    required this.termConditionData,
    this.errorFetchTermCondition,
    this.isLoadingTermCondition = false,
    required this.dataUserInfoProfile,
    this.errorFetchDataUserInfoProfile,
    this.isLoadingDataUserProfile = false,
    this.counter = 1,
    this.isLoadingMore =false,
    required this.dataSavedcourses,
    this.isLoadingdataSavedcourses,
    this.errorFetchdataSavedcourses
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
    int? counter,
    bool? isLoadingMore,
   DataResponseSaveCoursesPagination? dataSavedcourses,
    Failure? errorFetchdataSavedcourses,
    bool? isLoadingdataSavedcourses,
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
      dataUserInfoProfile: dataUserInfoProfile ?? this.dataUserInfoProfile,
      errorFetchDataUserInfoProfile: errorFetchDataUserInfoProfile,
      isLoadingDataUserProfile: isLoadingDataUserProfile ?? false,
      counter: counter ?? this.counter,
      isLoadingMore :isLoadingMore ??false,
      dataSavedcourses: dataSavedcourses ?? this.dataSavedcourses,
      errorFetchdataSavedcourses : errorFetchdataSavedcourses,
      isLoadingdataSavedcourses: isLoadingdataSavedcourses ?? false
    );
  }
}
