import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/widgets/app_loading_widget.dart';
import 'package:e_learning/features/auth/data/models/study_year_enum.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_cubit.dart';
import 'package:e_learning/features/auth/presentation/manager/auth_state.dart';
import 'package:e_learning/features/auth/presentation/widgets/input_select_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
            if (state.getUniversitiesState == ResponseStatusEnum.failure) {
              return Text(
                state.getUniversitiesError ?? "failed_to_load_universities".tr(),
                style: TextStyle(color: AppColors.textError),
              );
            } else {
              return AppLoadingWidget(
                isLoading: state.getUniversitiesState == ResponseStatusEnum.loading,
                child: InputSelectWidget(
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
                  onChanged: state.getUniversitiesState == ResponseStatusEnum.loading
                      ? null
                      : (value) {
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
                ),
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
                "select_university".tr(),
                style: TextStyle(color: AppColors.textGrey),
              );
            }

            switch (state.getCollegesState) {
              case ResponseStatusEnum.failure:
                return Text(
                  state.getCollegesError ?? "failed_to_load_colleges".tr(),
                  style: TextStyle(color: AppColors.textError),
                );

              case ResponseStatusEnum.success:
                if (state.colleges.isEmpty) {
                  return Text(
                    "no_colleges_for_university".tr(),
                    style: TextStyle(color: AppColors.textGrey),
                  );
                }

                return AppLoadingWidget(
                  isLoading: state.getCollegesState == ResponseStatusEnum.loading,
                  child: InputSelectWidget(
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
                    onChanged: state.getCollegesState == ResponseStatusEnum.loading
                        ? null
                        : (value) {
                            final selected = state.colleges.firstWhere(
                              (u) => u.name == value,
                            );

                            context.read<AuthCubit>().updateSignUpParams(
                              collegeId: selected.id,
                            );
                          },
                  ),
                );

              default:
                return AppLoadingWidget(
                  isLoading: state.getCollegesState == ResponseStatusEnum.loading,
                  child: const SizedBox.shrink(),
                );
            }
          },
        ),

        //?--------------------------- Study Year --------------------------
        BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (pre, cur) =>
              pre.signUpRequestParams?.studyYear !=
              cur.signUpRequestParams?.studyYear,
          builder: (context, state) {
            return InputSelectWidget(
              hint: "Choose Study Year",
              hintKey: "choose_study_year",
              options: SchoolYear.values
                  .map((e) => e.displayName())
                  .toList(),
              value: state.signUpRequestParams?.studyYear != null
                  ? SchoolYear.values
                        .firstWhere(
                          (e) =>
                              e.number == state.signUpRequestParams!.studyYear,
                        )
                        .displayName()
                  : null,
              onChanged: (value) {
                final selectedYear = SchoolYear.values.firstWhere(
                  (e) => e.displayName() == value,
                );

                final oldParams = context
                    .read<AuthCubit>()
                    .state
                    .signUpRequestParams;

                context.read<AuthCubit>().updateSignUpParams(
                  universityId: oldParams?.universityId,
                  collegeId: oldParams?.collegeId,
                  studyYear: selectedYear.number,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
