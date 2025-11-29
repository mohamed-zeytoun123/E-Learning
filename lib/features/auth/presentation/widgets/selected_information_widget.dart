import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/localization/manager/app_localization.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/input_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              return AppLoading.linear();
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
                value: state.signUpRequestParams?.universityId != null
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
                  );

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
                  cur.signUpRequestParams?.collegeId,
          builder: (context, state) {
            if (state.signUpRequestParams?.universityId == null) {
              return Text(
                AppLocalizations.of(context)?.translate("select_university") ??
                    "Select university",
                style: TextStyle(color: AppColors.textGrey),
              );
            }

            switch (state.getCollegesState) {
              case ResponseStatusEnum.loading:
                return AppLoading.linear();

              case ResponseStatusEnum.failure:
                return Text(
                  state.getCollegesError ??
                      AppLocalizations.of(
                        context,
                      )?.translate("failed_to_load_colleges") ??
                      "Failed to load colleges",
                  style: TextStyle(color: AppColors.textError),
                );

              case ResponseStatusEnum.success:
                context.read<AuthCubit>().getStudyYears();
                if (state.colleges.isEmpty) {
                  return Text(
                    AppLocalizations.of(
                          context,
                        )?.translate("no_colleges_for_university") ??
                        "No colleges for this university",
                    style: TextStyle(color: AppColors.textGrey),
                  );
                }

                return InputSelectWidget(
                  hint: "Choose College",
                  hintKey: "choose_college",
                  options: state.colleges.map((u) => u.name).toList(),
                  value: state.signUpRequestParams?.collegeId != null
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
                    );

                    context.read<AuthCubit>().updateSignUpParams(
                      collegeId: selected.id,
                    );
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
            // ما نعرض السنة إذا ما اختيرت الجامعة أو الكلية
            if (state.signUpRequestParams?.universityId == null ||
                state.signUpRequestParams?.collegeId == null) {
              return Text(
                AppLocalizations.of(
                      context,
                    )?.translate("select_university_and_college") ??
                    "Select university and college first",
                style: TextStyle(color: AppColors.textGrey),
              );
            }

            switch (state.getStudyYearsState) {
              case ResponseStatusEnum.loading:
                return AppLoading.linear();

              case ResponseStatusEnum.failure:
                return Text(
                  state.studyYearsError ??
                      AppLocalizations.of(
                        context,
                      )?.translate("failed_to_load_study_years") ??
                      "Failed to load study years",
                  style: TextStyle(color: AppColors.textError),
                );

              case ResponseStatusEnum.success:
                if (state.studyYears!.isEmpty) {
                  return Text(
                    AppLocalizations.of(
                          context,
                        )?.translate("no_study_years_available") ??
                        "No study years available",
                    style: TextStyle(color: AppColors.textGrey),
                  );
                }

                return InputSelectWidget(
                  hint: "Choose Study Year",
                  hintKey: "choose_study_year",
                  options: state.studyYears!.map((sy) => sy.name).toList(),
                  value: state.signUpRequestParams?.studyYear != null
                      ? state.studyYears
                            ?.firstWhere(
                              (sy) =>
                                  sy.id == state.signUpRequestParams!.studyYear,
                            )
                            .name
                      : null,
                  onChanged: (value) {
                    final selectedYear = state.studyYears?.firstWhere(
                      (sy) => sy.name == value,
                    );

                    context.read<AuthCubit>().updateSignUpParams(
                      studyYear: selectedYear?.id,
                    );
                  },
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
