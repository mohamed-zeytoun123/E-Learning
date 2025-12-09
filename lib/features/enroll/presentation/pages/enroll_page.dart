import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/video_progress_widget.dart';
import 'package:e_learning/features/enroll/data/models/enums/course_state_enum.dart';
import 'package:e_learning/features/enroll/data/source/static/dummy_courses.dart';
import 'package:e_learning/features/enroll/presentation/widgets/completed_section_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/custom_state_tab_bar_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/enroll_info_card_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/suspended_section_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
    // Filter courses based on selected state
    final filteredCourses = courses
        .where((course) => course['courseState'] == selectedCourseState)
        .toList();

    return Scaffold(
      appBar: CustomAppBarWidget(title: 'enroll'.tr(), showBack: true),
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
                child: Builder(
                  builder: (_) {
                    return ListView.separated(
                      itemCount: filteredCourses.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        switch (selectedCourseState) {
                          case CourseStateEnum.active:
                            return EnrollInfoCardWidget(
                              imageUrl: filteredCourses[index]['imageUrl'],
                              courseTitle: filteredCourses[index]
                                  ['courseTitle'],
                              courseState: filteredCourses[index]
                                  ['courseState'],
                              stateSectionWidget: VideoProgressWidget(
                                completed: 12,
                                // videoCount: 40,
                                total: 65,
                              ),
                              height: 203,
                            );
                          case CourseStateEnum.completed:
                            return EnrollInfoCardWidget(
                              imageUrl: filteredCourses[index]['imageUrl'],
                              courseTitle: filteredCourses[index]
                                  ['courseTitle'],
                              courseState: filteredCourses[index]
                                  ['courseState'],
                              stateSectionWidget: CompletedSectionWidget(
                                isRated: filteredCourses[index]['isRated'],
                              ),
                              height: 201,
                            );
                          case CourseStateEnum.suspended:
                            return EnrollInfoCardWidget(
                              imageUrl: filteredCourses[index]['imageUrl'],
                              courseTitle: filteredCourses[index]
                                  ['courseTitle'],
                              courseState: filteredCourses[index]
                                  ['courseState'],
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
