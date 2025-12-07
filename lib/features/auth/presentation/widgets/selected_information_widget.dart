import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/disabled_input_select_widget.dart';
import 'package:e_learning/features/auth/presentation/widgets/input_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class SelectedInformationWidget extends StatelessWidget {
  const SelectedInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20.h,
      children: [
        //?--------------------------- University ----------------------------
        BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (pre, cur) =>
              pre.getUniversitiesState != cur.getUniversitiesState ||
              pre.signUpRequestParams?.universityId !=
                  cur.signUpRequestParams?.universityId,
          builder: (context, state) {
            if (state.getUniversitiesState == ResponseStatusEnum.loading) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: AppLoading.linear(),
              );
            } else if (state.getUniversitiesState ==
                ResponseStatusEnum.failure) {
              return Text(
                state.getUniversitiesError ??
                    AppLocalizations.of(
                      context,
                    )?.translate("failed_to_load_universities") ??
                    "Failed to load universities",
                style: TextStyle(color: AppColors.textError),
              );
            } else {
              return InputSelectWidget(
                hint: "Choose University",
                hintKey: "choose_university",
                options: state.universities.map((u) => u.name).toList(),
                value:
                    state.signUpRequestParams?.universityId != null &&
                        state.universities.any(
                          (u) =>
                              u.id == state.signUpRequestParams!.universityId,
                        )
                    ? state.universities
                          .firstWhere(
                            (u) =>
                                u.id == state.signUpRequestParams!.universityId,
                          )
                          .name
                    : null,
                onChanged: (value) {
                  final selected = state.universities.firstWhere(
                    (u) => u.name == value,
                    orElse: () => state.universities.first,
                  );

                  // Reset college selection when university changes
                  context.read<AuthCubit>().updateSignUpParams(
                    universityId: selected.id,
                    collegeId: null,
                  );

                  context.read<AuthCubit>().getColleges(
                    universityId: selected.id,
                  );
                },
              );
            }
          },
        ),

        //?--------------------------- College -----------------------------
        BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (pre, cur) =>
              pre.getCollegesState != cur.getCollegesState ||
              pre.colleges != cur.colleges ||
              pre.signUpRequestParams?.collegeId !=
                  cur.signUpRequestParams?.collegeId ||
              pre.signUpRequestParams?.universityId !=
                  cur.signUpRequestParams?.universityId,
          builder: (context, state) {
            final bool isUniversitySelected =
                state.signUpRequestParams?.universityId != null;

            if (!isUniversitySelected) {
              return DisabledInputSelectWidget(
                hint:
                    AppLocalizations.of(
                      context,
                    )?.translate("choose_university_first") ??
                    "Choose university first",
                onTapMessage:
                    AppLocalizations.of(context)?.translate(
                      "please_select_university_before_selecting_college",
                    ) ??
                    "Please select a university before selecting a college",
              );
            }

            switch (state.getCollegesState) {
              case ResponseStatusEnum.loading:
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: AppLoading.linear(),
                );

              case ResponseStatusEnum.failure:
                if (state.getCollegesError?.contains("No Data") == true) {
                  String universityName = "";
                  if (state.signUpRequestParams?.universityId != null) {
                    try {
                      final selectedUniversity = state.universities.firstWhere(
                        (u) => u.id == state.signUpRequestParams!.universityId,
                      );
                      universityName = selectedUniversity.name;
                    } catch (e) {
                      universityName = "Unknown University";
                    }
                  }

                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDisabled,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.borderSecondary),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.textGrey,
                          size: 24.sp,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          AppLocalizations.of(
                                context,
                              )?.translate("no_colleges_for_university") ??
                              "No colleges for this university",
                          style: AppTextStyles.s14w400.copyWith(
                            color: AppColors.textGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          universityName,
                          style: AppTextStyles.s14w500.copyWith(
                            color: AppColors.textGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text(
                    state.getCollegesError ??
                        AppLocalizations.of(
                          context,
                        )?.translate("failed_to_load_colleges") ??
                        "Failed to load colleges",
                    style: TextStyle(color: AppColors.textError),
                  );
                }

              case ResponseStatusEnum.success:
                if (state.colleges.isEmpty) {
                  String universityName = "";
                  if (state.signUpRequestParams?.universityId != null) {
                    try {
                      final selectedUniversity = state.universities.firstWhere(
                        (u) => u.id == state.signUpRequestParams!.universityId,
                      );
                      universityName = selectedUniversity.name;
                    } catch (e) {
                      universityName = "Unknown University";
                    }
                  }

                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDisabled,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.borderSecondary),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.textGrey,
                          size: 24.sp,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          AppLocalizations.of(
                                context,
                              )?.translate("no_colleges_for_university") ??
                              "No colleges for this university",
                          style: AppTextStyles.s14w400.copyWith(
                            color: AppColors.textGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          universityName,
                          style: AppTextStyles.s14w500.copyWith(
                            color: AppColors.textGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return InputSelectWidget(
                  hint: "Choose College",
                  hintKey: "choose_college",
                  options: state.colleges.map((u) => u.name).toList(),
                  value:
                      state.signUpRequestParams?.collegeId != null &&
                          state.colleges.any(
                            (u) => u.id == state.signUpRequestParams!.collegeId,
                          )
                      ? state.colleges
                            .firstWhere(
                              (u) =>
                                  u.id == state.signUpRequestParams!.collegeId,
                            )
                            .name
                      : null,
                  onChanged: (value) {
                    final selected = state.colleges.firstWhere(
                      (u) => u.name == value,
                      orElse: () => state.colleges.first,
                    );

                    context.read<AuthCubit>().updateSignUpParams(
                      collegeId: selected.id,
                    );

                    context.read<AuthCubit>().getStudyYears();
                  },
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),

        //?--------------------------- Study Year --------------------------
        BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (pre, cur) =>
              pre.getStudyYearsState != cur.getStudyYearsState ||
              pre.signUpRequestParams?.studyYear !=
                  cur.signUpRequestParams?.studyYear,
          builder: (context, state) {
            final studyYears = state.studyYears ?? [];

            // Always show the study year field like university
            return InputSelectWidget(
              hint: "Choose Study Year",
              hintKey: "choose_study_year",
              options: studyYears.isNotEmpty
                  ? studyYears.map((sy) => sy.name).toList()
                  : ["Loading..."],
              value:
                  state.signUpRequestParams?.studyYear != null &&
                      studyYears.any(
                        (sy) => sy.id == state.signUpRequestParams!.studyYear,
                      )
                  ? studyYears
                        .firstWhere(
                          (sy) => sy.id == state.signUpRequestParams!.studyYear,
                        )
                        .name
                  : null,
              onChanged: (value) {
                if (studyYears.isEmpty) return;
                final selectedYear = studyYears.firstWhere(
                  (sy) => sy.name == value,
                  orElse: () => studyYears.first,
                );

                context.read<AuthCubit>().updateSignUpParams(
                  studyYear: selectedYear.id,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
