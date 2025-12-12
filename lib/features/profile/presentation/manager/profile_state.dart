// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/profile/data/model/data_college_model.dart';
import 'package:e_learning/features/profile/data/model/data_course_saved_model.dart';
import 'package:e_learning/features/profile/data/model/data_univarcity_response_model.dart';
import 'package:e_learning/features/profile/data/model/data_year_response_model.dart';
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
  final DataResonseunivarsity? dataUnivarcity;
  final bool? isLoadingdataUnivarcity;
  final Failure? errorFetchdataUnivarcity;
  final DataResonseCollege? dataCollege;
  final bool? isLoadingdataCollege;
  final Failure? errorFetchdataCollege;
  final DataResonseYearStudent? dataYearStudent;
  final bool? isLoadingdataYearStudent;
  final Failure? errorFetchdataYearStudent;
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
    this.errorFetchdataSavedcourses,
    this.dataUnivarcity,
    this.isLoadingdataUnivarcity,
    this.errorFetchdataUnivarcity,
    this.dataCollege,
    this.errorFetchdataCollege,
    this.isLoadingdataCollege,
    this.dataYearStudent,
    this.errorFetchdataYearStudent,
    this.isLoadingdataYearStudent,
    
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
    DataResonseunivarsity? dataUnivarcity,
    bool? isLoadingdataUnivarcity,
    Failure? errorFetchdataUnivarcity,
    DataResonseCollege? dataCollege,
    bool? isLoadingdataCollege,
    Failure? errorFetchdataCollege,
    DataResonseYearStudent? dataYearStudent,
    bool? isLoadingdataYearStudent,
    Failure? errorFetchdataYearStudent,

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
      isLoadingdataSavedcourses: isLoadingdataSavedcourses ?? false,
      dataUnivarcity: dataUnivarcity ?? this.dataUnivarcity,
      isLoadingdataUnivarcity: isLoadingdataUnivarcity ?? false,
      errorFetchdataUnivarcity: errorFetchdataUnivarcity,
      errorFetchdataCollege: errorFetchdataCollege,
      isLoadingdataCollege: isLoadingdataCollege ?? false,
      dataCollege: dataCollege ?? this.dataCollege,
      dataYearStudent: dataYearStudent ?? this.dataYearStudent,
      isLoadingdataYearStudent: isLoadingdataYearStudent ?? false, 
      errorFetchdataYearStudent: errorFetchdataYearStudent,
    );
  }
}
