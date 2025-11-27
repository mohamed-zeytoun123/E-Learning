import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/core/widgets/custom_app_bar_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/video_progress_widget.dart';
import 'package:e_learning/features/enroll/data/source/repo/enroll_repository.dart';
import 'package:e_learning/features/enroll/presentation/manager/enroll_cubit.dart';
import 'package:e_learning/features/enroll/presentation/manager/enroll_state.dart';
import 'package:e_learning/features/enroll/presentation/widgets/completed_section_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/custom_state_tab_bar_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/enroll_info_card_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/suspended_section_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnrollPage extends StatelessWidget {
  const EnrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EnrollCubit(repository: di<EnrollRepository>())..getMyCourses(),
      child: const _EnrollPageContent(),
    );
  }
}

class _EnrollPageContent extends StatelessWidget {
  const _EnrollPageContent();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: CustomAppBarWidget(title: 'enroll'.tr(), showBack: true),
      body: BlocBuilder<EnrollCubit, EnrollState>(
        builder: (context, state) {
          if (state.getMyCoursesState == ResponseStatusEnum.loading) {
            return Center(child: AppLoading.circular());
          }

          if (state.getMyCoursesState == ResponseStatusEnum.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.getMyCoursesError ?? 'Failed to load enrollments',
                    style: TextStyle(color: colors.textGrey),
                  ),
                  16.sizedH,
                  ElevatedButton(
                    onPressed: () => context.read<EnrollCubit>().getMyCourses(),
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            );
          }

          // Check if there are any enrollments at all
          if (state.enrollments.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'no_enrollments_found'.tr(),
                      style: TextStyle(color: colors.textGrey),
                      textAlign: TextAlign.center,
                    ),
                    16.sizedH,
                    ElevatedButton(
                      onPressed: () =>
                          context.read<EnrollCubit>().getMyCourses(),
                      child: Text('retry'.tr()),
                    ),
                  ],
                ),
              ),
            );
          }

          final filteredEnrollments = state.filteredEnrollments;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 8.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomStateTabBarWidget(
                    onTabSelected: (index) {
                      context.read<EnrollCubit>().changeSelectedState(
                            CourseStateEnum.values[index],
                          );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Divider(color: colors.dividerGrey),
                  ),
                  if (filteredEnrollments.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.h),
                        child: Text(
                          'no_enrollments_in_category'.tr(),
                          style: TextStyle(color: colors.textGrey),
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: ListView.separated(
                        itemCount: filteredEnrollments.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final enrollment = filteredEnrollments[index];

                          switch (state.selectedState) {
                            case CourseStateEnum.active:
                              return EnrollInfoCardWidget(
                                imageUrl: enrollment.courseImage ?? '',
                                courseTitle: enrollment.courseTitle,
                                courseState: CourseStateEnum.active,
                                stateSectionWidget: VideoProgressWidget(
                                  completed:
                                      enrollment.progressPercentage.toInt(),
                                  total: 100,
                                ),
                                height: 203,
                              );
                            case CourseStateEnum.completed:
                              return EnrollInfoCardWidget(
                                imageUrl: enrollment.courseImage ?? '',
                                courseTitle: enrollment.courseTitle,
                                courseState: CourseStateEnum.completed,
                                stateSectionWidget: CompletedSectionWidget(
                                  isRated:
                                      false, // TODO: Check if rated from courseRatingsMap
                                ),
                                height: 201,
                              );
                            case CourseStateEnum.suspended:
                              return EnrollInfoCardWidget(
                                imageUrl: enrollment.courseImage ?? '',
                                courseTitle: enrollment.courseTitle,
                                courseState: CourseStateEnum.suspended,
                                stateSectionWidget: SuspendedSectionWidget(),
                                height: 236,
                              );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return 15.sizedH;
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
