import 'dart:developer';

import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/custom_app_bar_widget.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_cubit.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getTermsConditionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: CustomAppBarWidget(title: 'Term & Conditions', showBack: true),
      body: Container(
        padding: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          color: context.colors.appBarWhite,
          // gradient: LinearGradient(colors: [context.colors.appBarWhite])
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 1.r, 24, 0),
          decoration: BoxDecoration(
            color: context.colors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              // topRight: Radius.circular(36.r),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (previous, current) =>
                    previous.termConditionData != current.termConditionData ||
                    previous.errorFetchTermCondition !=
                        current.errorFetchTermCondition ||
                    previous.isLoadingTermCondition !=
                        current.isLoadingTermCondition,

                builder: (context, state) {
                  log('rebuild cubit 😒');
                  if (state.isLoadingTermCondition == true) {
                    return Center(
                      child: SizedBox(
                        width: 100,
                        height: 500,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }
                  if (state.errorFetchTermCondition != null) {
                    return SizedBox(height: 500.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64.sp,
                              color: context.colors.iconRed,
                            ),
                            16.sizedH,
                            Text(
                              'Error loading Term & conditions',
                              style: AppTextStyles.s16w500.copyWith(
                                color: context.colors.textPrimary,
                              ),
                            ),
                            8.sizedH,
                            Text(
                              state.errorFetchTermCondition!.message,
                              style: AppTextStyles.s14w400.copyWith(
                                color: context.colors.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      ...List.generate(1, (index) {
                        return privacyPolicySectionWidget(
                          title: state.termConditionData.title,
                          text: state.termConditionData.content,
                          counter: index + 1,
                        );
                      }),

                      // privacyPolicySectionWidget(
                      //   title: ' Type of data collect ',
                      //   text: '',
                      //   counter: 1,
                      // ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class privacyPolicySectionWidget extends StatelessWidget {
  const privacyPolicySectionWidget({
    super.key,
    required this.title,
    required this.text,
    required this.counter,
  });
  final String title;
  final String text;
  final int counter;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$counter. $title',
          style: TextStyle(
            color: context.colors.textBlue,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        8.sizedH,
        Text(
          text,
          style: TextStyle(
            color: context.colors.textGrey,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        24.sizedH,
      ],
    );
  }
}
