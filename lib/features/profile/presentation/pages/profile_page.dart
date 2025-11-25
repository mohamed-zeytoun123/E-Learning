import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/custom_app_bar_widget.dart';
import 'package:e_learning/core/widgets/input_name_widget.dart';
import 'package:e_learning/core/widgets/input_phone_widget.dart';
import 'package:e_learning/features/profile/data/models/data_univarcity_response_model.dart';
import 'package:e_learning/features/profile/data/models/user_data_info_model.dart';
import 'package:e_learning/features/profile/data/source/repo/profile_repository.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_cubit.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_state.dart';
import 'package:e_learning/features/profile/presentation/widgets/custom_settings_item_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/language_bottom_sheet_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/log_out_show_dialog.dart';
import 'package:e_learning/features/profile/presentation/widgets/modal_sheet_custom_container_widget.dart';
import 'package:e_learning/features/profile/presentation/widgets/profile_guest_header.dart';
import 'package:e_learning/features/profile/presentation/widgets/profile_user_header.dart';
import 'package:e_learning/features/profile/presentation/widgets/theme_bottom_sheet_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getDataSavedCourse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBarWidget(
        title: 'Profile Page',
        showBack: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 42.h,
          bottom: 32.h,
          right: 16.w,
          left: 16.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //TODO: Pass user data to ProfileUserHeader and UserInfoRow
              BlocBuilder<AppManagerCubit, AppManagerState>(
                buildWhen: (previous, current) =>
                    previous.appState != current.appState,
                builder: (context, state) {
                  if (state.appState == AppStateEnum.user) {
                    return Column(
                      children: [
                        ProfileUserHeader(),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    );
                  } else {
                    return ProfileGuestHeader();
                  }
                },
              ),
              32.sizedH,
              CustomSettingsItemWidget(
                icon: Icons.bookmark_outline,
                iconColor: colors.textBlue,
                title: "Saved_Courses".tr(),
                onTap: () {
                  context.push(
                    RouteNames.savedCourses,
                    extra: BlocProvider.of<ProfileCubit>(context),
                  );
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.download_outlined,
                iconColor: context.colors.textBlue,
                title: "Downloads".tr(),
                onTap: () {
                  context.push(RouteNames.downloads);
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.language_outlined,
                iconColor: context.colors.textBlue,
                title: "Languages".tr(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.black,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: LanguageBottomSheetWidget(),
                    ),
                  );
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.light_mode_outlined,
                iconColor: colors.textBlue,
                title: "Colors_Mode".tr(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: colors.background,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: ThemeBottomSheetWidget(),
                    ),
                  );
                },
              ),
              BlocBuilder<AppManagerCubit, AppManagerState>(
                  builder: (context, state) {
                if (state.appState == AppStateEnum.guest) {
                  return SizedBox.shrink();
                }
                return CustomSettingsItemWidget(
                    icon: Icons.settings_applications_sharp,
                    iconColor: context.colors.textBlue,
                    title: 'Edit profile',
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: context.colors.background,
                          isScrollControlled: true,
                          builder: (context) =>
                              BlocBuilder<ProfileCubit, ProfileState>(
                                  builder: (context, state) {
                                return SingleChildScrollView(
                                  child: EditDataProfileBottomSheetWidget(
                                    dataUser: state.dataUserInfoProfile,
                                    idUniversity:
                                        state.dataUserInfoProfile.universityId,
                                    phone: TextEditingController(
                                        text: state.dataUserInfoProfile.phone),
                                    userName: TextEditingController(
                                        text:
                                            state.dataUserInfoProfile.fullName),
                                  ),
                                );
                              }));
                    });
              }),
              CustomSettingsItemWidget(
                icon: Icons.shield_outlined,
                iconColor: colors.textBlue,
                title: "Privacy_Policy".tr(),
                onTap: () {
                  // BlocProvider.of<ProfileCubit>(
                  //   context,
                  // ).getPrivacyPolicyData();
                  context.push(
                    RouteNames.privacy,
                    extra: context.read<ProfileCubit>(),
                  );
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.newspaper_outlined,
                iconColor: colors.textBlue,
                title: "Terms_&_Conditions".tr(),
                onTap: () {
                  di<ProfileRepository>().getTermsConditionsData();
                  context.push(
                    RouteNames.term,
                    extra: context.read<ProfileCubit>(),
                  );
                  // context.push(RouteNames.term);
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.article_outlined,
                iconColor: colors.textBlue,
                title: "About_Us".tr(),
                onTap: () {
                  context.push(
                    RouteNames.aboutUs,
                    extra: context.read<ProfileCubit>(),
                  );
                  // context.push(RouteNames.aboutUs);
                  // appLocator<ProfileRemouteDataSource>().getAboutUpInfo();
                  // appLocator<ProfileRepository>().getAboutUsRepo();
                  // print('ghassan');
                },
              ),
              CustomSettingsItemWidget(
                icon: Icons.logout_outlined,
                iconColor: context.colors.iconRed,
                title: "Log_Out".tr(),
                titleColor: context.colors.textRed,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showDialogLogOut();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditDataProfileBottomSheetWidget extends StatefulWidget {
  const EditDataProfileBottomSheetWidget(
      {super.key,
      required this.phone,
      required this.userName,
      required this.idUniversity,
      required this.dataUser});
  final TextEditingController phone;
  final TextEditingController userName;
  final int idUniversity;
  final UserDataInfoModel dataUser;

  @override
  State<EditDataProfileBottomSheetWidget> createState() =>
      _EditDataProfileBottomSheetWidgetState();
}

class _EditDataProfileBottomSheetWidgetState
    extends State<EditDataProfileBottomSheetWidget> {
  // final TextEditingController year = TextEditingController();
  final GlobalKey _form = GlobalKey();
  int? selectedUnivacity;
  int? selectedCollege;
  int? selectedYear;
  @override
  initState() {
    selectedUnivacity = widget.idUniversity;
    BlocProvider.of<ProfileCubit>(context).getDataUnivarsity();
    BlocProvider.of<ProfileCubit>(context).getYearDataStudent();
    BlocProvider.of<ProfileCubit>(context).getDataCollege(widget.idUniversity);
    selectedCollege = widget.dataUser.collegeId;
    selectedYear = widget.dataUser.studyYearId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalSheetCustomContainerWidget(
      height: 700,
      child: Form(
        key: _form,
        child:
            BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('phone number'),
              SizedBox(
                height: 12.h,
              ),
              InputPhoneWidget(
                controller: widget.phone,
              ),
              Text(
                'User name',
              ),
              SizedBox(
                height: 12.h,
              ),
              InputNameWidget(
                controller: widget.userName,
                hint: 'Full Name',
                hintKey: 'Full_name',
              ),
              Column(
                children: [
                  Text(
                    'univarcity',
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  DropdownButtonFormField<int>(
                    value: state.dataUserInfoProfile.universityId,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    items: (state.dataUnivarcity?.results ?? [])
                        .map((UniData value) {
                      return DropdownMenuItem<int>(
                        value: value.id,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      selectedUnivacity = newValue;
                      BlocProvider.of<ProfileCubit>(context)
                          .getDataCollege(newValue!);
                      // Do something with the new value
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Skeletonizer(
                enabled: state.isLoadingdataCollege == true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'college',
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    DropdownButtonFormField<int>(
                      value: state.dataUserInfoProfile.collegeId,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      items: (state.dataCollege?.results ?? []).map((value) {
                        return DropdownMenuItem<int>(
                          value: value.id,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        selectedCollege = newValue;
                        // Do something with the new value
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Skeletonizer(
                enabled: state.isLoadingdataYearStudent == true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'year',
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    DropdownButtonFormField<int>(
                      value: state.dataUserInfoProfile.studyYearId,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      items:
                          (state.dataYearStudent?.results ?? []).map((value) {
                        return DropdownMenuItem<int>(
                          value: value.id,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        selectedYear = newValue;
                        // Do something with the new value
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<ProfileCubit>(context).EditDataProfileStudent(
                      widget.phone.text,
                      widget.userName.text,
                      selectedUnivacity!,
                      selectedCollege!,
                      selectedYear!);
                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: context.colors.textBlue,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                      child: Text(
                    'Edit',
                    style: AppTextStyles.s16w600
                        .copyWith(color: context.colors.background),
                  )),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
