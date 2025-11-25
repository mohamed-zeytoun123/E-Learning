import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/widgets/app_logo.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/features/auth/data/models/params/sign_up_request_params.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/selected_information_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
              AppLogo(),
              5.sizedH,
              Text(
                "Lets_make_your_account".tr(),
                style: AppTextStyles.s14w400.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              40.sizedH,
              Text(
                "We_are_one_step_away".tr(),
                style: AppTextStyles.s16w600.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              40.sizedH,
              SelectedInformationWidget(),
              20.sizedH,
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
                    title: "next".tr(),
                    buttonColor: isAllFilled
                        ? AppColors.buttonPrimary
                        : AppColors.buttonGreyF,
                    onTap: isAllFilled
                        ? () {
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
