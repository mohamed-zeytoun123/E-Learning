import 'dart:developer';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/pages/otp_page.dart';
import 'package:e_learning/features/auth/presentation/widgets/header_auth_pages_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/selected_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UniversitySelectionPage extends StatefulWidget {
  const UniversitySelectionPage({super.key, required this.phone});

  final String phone;

  @override
  State<UniversitySelectionPage> createState() =>
      _UniversitySelectionPageState();
}

class _UniversitySelectionPageState extends State<UniversitySelectionPage> {
  Future<void> _refreshUniversities() async {
    await context.read<AuthCubit>().getUniversities();
  }

  @override
  void initState() {
    super.initState();
    _refreshUniversities();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'UniversitySelectionPage rebuilt ===========================>> ${widget.phone}',
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        color: AppColors.buttonPrimary,
        backgroundColor: AppColors.background,
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
              BlocSelector<AuthCubit, AuthState, SignUpRequestParams?>(
                selector: (state) => state.signUpRequestParams,
                builder: (context, signUpParams) {
                  final isAllFilled =
                      (signUpParams?.fullName.isNotEmpty ?? false) &&
                      signUpParams?.universityId != null &&
                      signUpParams?.collegeId != null &&
                      signUpParams?.studyYear != null &&
                      (signUpParams?.phone.isNotEmpty ?? false) &&
                      (signUpParams?.password.isNotEmpty ?? false);

                  return CustomButton(
                    title:
                        AppLocalizations.of(context)?.translate("next") ??
                        "Next",
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
                    onTap: isAllFilled
                        ? () {
                            log("dsfdfsf");

                            context.push(
                              RouteNames.otpScreen,
                              extra: {
                                'blocProvide': BlocProvider.of<AuthCubit>(
                                  context,
                                ),
                                'phone': widget.phone,
                                'purpose': 'register',
                              },
                            );
                          }
                        : null,
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
