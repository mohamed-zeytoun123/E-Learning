import 'dart:developer';

import 'package:e_learning/features/profile/data/model/data_course_saved_model.dart';
import 'package:e_learning/features/profile/data/model/response_data_privacy_policy_model.dart';
import 'package:e_learning/features/profile/data/model/user_data_info_model.dart';
import 'package:e_learning/features/profile/data/source/repo/profile_repository.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repo)
    : super(
        ProfileState(
          dataSavedcourses: DataResponseSaveCoursesPagination(count: 1, next: null, previous: null, totalPages: 2, currentPage: 1, pageSize: 10, data: []),
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
    //  int currentPage = 1;    // 📌 تتبع الصفحة الحالية
    //  int totalPages = 3;   
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

  void counterPage() {
    var counter = state.counter;
    counter = counter! + 1;
    print('$counter ❤️❤️❤️');
    emit(state.copyWith(counter: counter));
  }




  Future<void> getDataSavedCourse() async {
    // 🔒 تحقق من أن التحميل ليس جاريًا وأن هناك صفحة تالية
    if (state.isLoadingMore == true || state.dataSavedcourses.currentPage > state.dataSavedcourses.totalPages) {
      log('⏳ تجاهل الطلب — التحميل جاري أو انتهت الصفحات');
      return;
    }

    log('🌍 Fetching page ${state.dataSavedcourses.totalPages}');

    emit(state.copyWith(isLoadingdataSavedcourses: true, isLoadingMore: true));

    var result = await repo.getDataSavedCoursesRepo();

    result.fold(
      (error) {
        emit(state.copyWith(
          errorFetchdataSavedcourses: error,
          isLoadingMore: false,
          isLoadingdataSavedcourses: false,
        ));
      },
      (data) {
        final updatedList = [...state.dataSavedcourses.data, ...data.data];

        // 🔹 تحديث pagination
        
      int  currentPage =   state.dataSavedcourses.currentPage +1;
    

        emit(state.copyWith(
          dataSavedcourses: data.copyWith(currentPage:currentPage ,data: updatedList),
          isLoadingMore: false,
          isLoadingdataSavedcourses: false,
        ));

        log('✅ page ${currentPage - 1} loaded, total pages ${state.dataSavedcourses.totalPages}');
      },
    );
  }





  // Future<void> getDataSavedCourse() async {
  //   log(
  //     '**********************************************************************************************************************',
  //   );
  //   emit(state.copyWith(isLoadingdataSavedcourses: true, isLoadingMore: true));
  //   var result = await repo.getDataSavedCoursesRepo();
  //   result.fold(
  //     (error) {
  //       emit(state.copyWith(errorFetchdataSavedcourses: error,isLoadingMore: false));
  //     },
  //     (data) {
  //       var counter = state.counter;
  //       counter = counter! + 1;
  //       log(" ✅👌 success  ,get data user from repo\n $data");
  //       emit(
  //         state.copyWith(isLoadingMore: false,
  //           dataSavedcourses: data,
  //           counter: counter,
  //         ),
  //       );
  //     },
  //   );
  // }
}
