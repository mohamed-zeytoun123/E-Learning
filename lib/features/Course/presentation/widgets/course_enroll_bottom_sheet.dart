import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Course/data/functions/open_link.dart';
import 'package:e_learning/features/Course/presentation/widgets/contact_icon_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/direct_payment_method_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/video_progress_widget.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/enroll/data/models/enums/course_state_enum.dart';
import 'package:e_learning/features/enroll/data/source/static/dummy_courses.dart';
import 'package:e_learning/features/enroll/presentation/widgets/completed_section_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/custom_state_tab_bar_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/enroll_info_card_widget.dart';
import 'package:e_learning/features/enroll/presentation/widgets/suspended_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CourseEnrollBottomSheet extends StatefulWidget {
  const CourseEnrollBottomSheet({super.key, required this.cubit});

  final CourseCubit cubit;
  @override
  State<CourseEnrollBottomSheet> createState() =>
      _CourseEnrollBottomSheetState();
}

class _CourseEnrollBottomSheetState extends State<CourseEnrollBottomSheet> {
  CourseStateEnum selectedCourseState = CourseStateEnum.active;

  @override
  void initState() {
    context.read<CourseCubit>().getChannels();
    super.initState();
  }

  void _onTabSelected(int index) {
    setState(() {
      selectedCourseState = CourseStateEnum.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state.channelsStatus == ResponseStatusEnum.loading) {
          return SizedBox(
            height: 200.h,

            child: Center(child: AppLoading.circular()),
          );
        } else if (state.channelsStatus == ResponseStatusEnum.failure) {
          return SizedBox(
            height: 200.h,
            child: Center(
              child: Column(
                spacing: 5.h,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 50.h,
                    color: AppColors.textError,
                  ),
                  Text(
                    state.channelsError ?? "Something went wrong",
                    style: AppTextStyles.s14w600.copyWith(
                      color: AppColors.textError,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomButtonWidget(
                    onTap: () {
                      context.read<CourseCubit>().getChannels();
                    },
                    title: "Retry",
                    titleStyle: AppTextStyles.s14w500.copyWith(
                      color: AppColors.titlePrimary,
                    ),
                    buttonColor: AppColors.buttonPrimary,
                    borderColor: AppColors.borderPrimary,
                  ),
                ],
              ),
            ),
          );
        } else if ((state.channelsStatus == ResponseStatusEnum.failure &&
                state.channelsError!.contains("No Data")) ||
            state.channels!.isEmpty) {
          return SizedBox(
            height: 200.h,
            child: Center(
              child: Column(
                spacing: 10.w,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 50.h,
                    color: AppColors.textError,
                  ),
                  Text(
                    "No Channels Available",
                    style: AppTextStyles.s14w600.copyWith(
                      color: AppColors.textError,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.channelsStatus == ResponseStatusEnum.success) {
          final channels = state.channels ?? [];

          final communications = channels
              .where((c) => c.isCommunication == true)
              .toList();
          final payments = channels
              .where((c) => c.isCommunication == false)
              .toList();
          // Filter courses based on selected state
          final filteredCourses = courses
              .where((course) => course['courseState'] == selectedCourseState)
              .toList();

          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              bottom: 15.h,
              top: 3.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 80.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: AppColors.dividerWhite,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Enrollment Channels Section
                        Text(
                          "Get Your Enrollment Code !",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Contact Us To Receive Payment Information & Enroll In This Course",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textGrey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: SizedBox(
                            height: 80.h,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(left: 5.w),
                              itemCount: communications.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return ContactIconWidget(
                                  iconPath: communications.elementAt(index).image ?? "",
                                  onTap: () {
                                    openLink(communications.elementAt(index).apiLink);
                                  },
                                  nameApp: communications.elementAt(index).name,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 15.w),
                            ),
                          ),
                        ),
                        Divider(
                          height: 10.h,
                          thickness: 1,
                          color: AppColors.dividerGrey,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Or Pay Directly Via",
                                style: AppTextStyles.s16w600.copyWith(
                                  color: AppColors.textBlack,
                                ),
                              ),
                              SizedBox(
                                height: 60.h,
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: payments.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return DirectPaymentMethodWidget(
                                      name: payments.elementAt(index).name,
                                      image: payments.elementAt(index).image ?? "",
                                      onTap: () {
                                        openLink(payments.elementAt(index).apiLink);
                                      },
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) =>
                                      SizedBox(width: 15.w),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Divider(
                          height: 10.h,
                          thickness: 1,
                          color: AppColors.dividerGrey,
                        ),
                        SizedBox(height: 24.h),
                        
                        // Enrolled Courses Section - Exact copy from EnrollPage
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
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: CustomButtonWidget(
                    onTap: () {
                      context.pop();
                    },
                    title: "Close",
                    titleStyle: AppTextStyles.s16w400.copyWith(
                      color: AppColors.titlePrimary,
                    ),
                    buttonColor: AppColors.buttonPrimary,
                    borderColor: AppColors.borderPrimary,
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
