import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/selected_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UniversitySelectionPage extends StatefulWidget {
  const UniversitySelectionPage({super.key, required this.email});

  final String email;

  @override
  State<UniversitySelectionPage> createState() =>
      _UniversitySelectionPageState();
}

class _UniversitySelectionPageState extends State<UniversitySelectionPage> {
  Future<void> _refreshUniversities() async {
    final cubit = context.read<AuthCubit>();
    await cubit.getUniversities();
    await cubit.getStudyYears();
  }

  @override
  void initState() {
    super.initState();
    _refreshUniversities();
  }

  @override
  Widget build(BuildContext context) {
    log('UniversitySelectionPage rebuilt  ${widget.email}');
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: RefreshIndicator(
        color: AppColors.buttonPrimary,
        backgroundColor: AppColors.backgroundPage,
        onRefresh: _refreshUniversities,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            top: 120.h,
            bottom: 50.h,
            right: 15.w,
            left: 15.w,
          ),
          child: Column(
            children: [
              HeaderAuthPagesWidget(),
              SizedBox(height: 5.h),
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate("Lets_make_your_account") ??
                    "Let’s Make Your Account !",
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate("We_are_one_step_away") ??
                    "We Are One Step Away !",
                style: AppTextStyles.s16w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 40.h),
              SelectedInformationWidget(),
              SizedBox(height: 20.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  
                  if (state.signUpState == ResponseStatusEnum.success) {
                    if (context.mounted) {
                      context.go(
                        RouteNames.otpScreen,
                        extra: {
                          'blocProvide': BlocProvider.of<AuthCubit>(context),
                          'email': widget.email,
                          'purpose': 'register',
                        },
                      );
                    }
                  } else if (state.signUpState == ResponseStatusEnum.failure) {
                    final errorMessage =
                        state.signUpError ??
                        AppLocalizations.of(
                          context,
                        )?.translate("Sign_up_failed") ??
                        "Sign up failed";

                    if (context.mounted) {
                      AppMessage.showFlushbar(
                        isShowProgress: true,
                        iconData: Icons.error_outline,
                        title: "Error",
                        context: context,
                        message: errorMessage,
                        backgroundColor: AppColors.textError,
                      );
                    }
                  }
                },

                builder: (context, state) {
                  if (state.signUpState == ResponseStatusEnum.loading) {
                    return Center(child: AppLoading.circular());
                  } else {
                    final signUpParams = state.signUpRequestParams;

                    final isAllFilled =
                        (signUpParams?.fullName.isNotEmpty ?? false) &&
                        signUpParams?.universityId != null &&
                        signUpParams?.collegeId != null &&
                        signUpParams?.studyYear != null &&
                        (signUpParams?.email.isNotEmpty ?? false) &&
                        (signUpParams?.password.isNotEmpty ?? false);

                    final isLoading =
                        state.signUpState == ResponseStatusEnum.loading;

                    // زر "Next"
                    return CustomButtonWidget(
                      title: "Next",

                      titleStyle: AppTextStyles.s16w500.copyWith(
                        color: isAllFilled
                            ? AppColors.titlePrimary
                            : AppColors.titleBlack,
                        fontFamily: AppTextStyles.fontGeist,
                      ),

                      buttonColor: isAllFilled
                          ? AppColors.buttonPrimary
                          : AppColors.buttonGreyF,

                      borderColor: AppColors.borderBrand,

                      // الحالة: تحميل → زر معطل
                      onTap: (isAllFilled && !isLoading)
                          ? () {
                              context.read<AuthCubit>().signUp(
                                params: signUpParams!,
                              );
                            }
                          : null,

                      // دائرة التحميل داخل الزر
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
