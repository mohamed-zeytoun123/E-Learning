import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/course/presentation/widgets/video_progress_widget.dart';
import 'package:e_learning/features/enroll/data/models/enums/course_state_enum.dart';
import 'package:e_learning/features/enroll/presentation/manager/enroll_cubit.dart';
import 'package:e_learning/features/enroll/presentation/manager/enroll_state.dart';
import 'package:e_learning/features/enroll/presentation/widgets/completed_section_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/custom_state_tab_bar_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/enroll_error_state_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/enroll_info_card_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/suspended_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnrollPage extends StatefulWidget {
  const EnrollPage({super.key});

  @override
  State<EnrollPage> createState() => _EnrollPageState();
}

class _EnrollPageState extends State<EnrollPage> {
  CourseStateEnum selectedCourseState = CourseStateEnum.active;

  void _onTabSelected(int index) {
    setState(() {
      selectedCourseState = CourseStateEnum.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Enroll', showBack: true),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 8.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomStateTabBarWidget(onTabSelected: _onTabSelected),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Divider(color: AppColors.dividerGrey),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: BlocBuilder<EnrollCubit, EnrollState>(
                  buildWhen: (previous, current) {
                    return previous.getMyCoursesState !=
                            current.getMyCoursesState ||
                        previous.enrollments != current.enrollments ||
                        previous.getMyCoursesError != current.getMyCoursesError;
                  },
                  builder: (context, state) {
                    if (state.getMyCoursesState == ResponseStatusEnum.loading) {
                      return AppLoading.circular();
                    }

                    if (state.getMyCoursesState == ResponseStatusEnum.failure) {
                      return EnrollErrorStateWidget();
                    }

                    // Filter courses based on selected state
                    final filteredCourses = state.enrollments.where((
                      enrollment,
                    ) {
                      final courseState = CourseStateEnum.fromApiStatus(
                        enrollment.status,
                        enrollment.isCompleted,
                      );
                      return courseState == selectedCourseState;
                    }).toList();
                    // Show message if no courses found
                    if (filteredCourses.isEmpty) {
                      return Center(
                        child: Text(
                          'No ${selectedCourseState.name} courses found',
                          style: AppTextStyles.s16w400.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: filteredCourses.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final enrollment = filteredCourses[index];
                        final courseState = CourseStateEnum.fromApiStatus(
                          enrollment.status,
                          enrollment.isCompleted,
                        );

                        switch (courseState) {
                          case CourseStateEnum.active:
                            return EnrollInfoCardWidget(
                              imageUrl: enrollment.courseImage ?? '',
                              courseTitle: enrollment.courseTitle,
                              courseState: courseState,
                              stateSectionWidget: VideoProgressWidget(
                                completedVideos:
                                    (enrollment.progressPercentage * 40 / 100)
                                        .round(),
                                totalVideos:
                                    40, // This should come from API in future
                              ),
                              height: 203,
                            );
                          case CourseStateEnum.completed:
                            return EnrollInfoCardWidget(
                              imageUrl: enrollment.courseImage ?? '',
                              courseTitle: enrollment.courseTitle,
                              courseState: courseState,
                              stateSectionWidget: CompletedSectionWidget(
                                courseSlug: enrollment.courseSlug,
                              ),
                              height: 201,
                            );
                          case CourseStateEnum.suspended:
                            return EnrollInfoCardWidget(
                              imageUrl: enrollment.courseImage ?? '',
                              courseTitle: enrollment.courseTitle,
                              courseState: courseState,
                              stateSectionWidget: SuspendedSectionWidget(),
                              height: 236,
                            );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 15.h);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
