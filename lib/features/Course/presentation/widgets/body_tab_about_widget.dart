import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/error/error_state_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_widget.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/icon_count_text_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/price_text_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/teacher_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabAboutWidget extends StatelessWidget {
  const BodyTabAboutWidget({
    super.key,
    required this.isActive,
    required this.courseId,
    required this.price,
    required this.countVideos,
    required this.countChapter,
    required this.houresDurtion,
  });
  final bool isActive;
  final int courseId;
  final int countVideos;
  final int countChapter;
  final double houresDurtion;
  final String price;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocBuilder<CourseCubit, CourseState>(
      buildWhen: (previous, current) =>
          previous.courseDetailsStatus != current.courseDetailsStatus,
      builder: (context, state) {
        switch (state.courseDetailsStatus) {
          case ResponseStatusEnum.loading:
            return Center(child: AppLoading.circular());

          case ResponseStatusEnum.failure:
            return ErrorStateWidget(
              message: state.courseDetailsError ?? 'Something went wrong',
              onRetry: () {
                context.read<CourseCubit>().getCourseDetails(id: "$courseId");
              },
            );

          case ResponseStatusEnum.success:
          case ResponseStatusEnum.initial:
            final details = state.courseDetails;
            if (details == null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 100.r,
                        color: AppColors.iconOrange,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "No Course Data",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.s20w600.copyWith(
                          color: AppColors.textBlack,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "There is currently no information available for this course.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.s16w400.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CustomButtonWidget(
                        title: "Retry",
                        titleStyle: AppTextStyles.s18w600.copyWith(
                          color: AppColors.titlePrimary,
                        ),
                        buttonColor: AppColors.buttonPrimary,
                        borderColor: AppColors.borderPrimary,
                        onTap: () {
                          context.read<CourseCubit>().getCourseDetails(
                                id: "$courseId",
                              );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            //?------------------------------------------------------------------------------------
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  spacing: 10.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Instructor",
                      style: AppTextStyles.s16w600.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    TeacherRowWidget(
                      teacherName: details.teacherName,
                      teacherImageUrl: details.teacherAvatar ?? "",
                    ),
                    Divider(
                      color: colors.dividerGrey,
                      thickness: 1,
                      height: 0.h,
                    ),
                    Text(
                      "About The Course",
                      style: AppTextStyles.s18w600.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      details.title,
                      style: AppTextStyles.s18w600.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      details.description,
                      style: AppTextStyles.s16w400.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Paid Price",
                          style: AppTextStyles.s16w600.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                        PriceTextWidget(price: details.price),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Divider(
                        color: colors.dividerGrey,
                        thickness: 1,
                        height: 0.h,
                      ),
                    ),
                    Text(
                      "Content",
                      style: AppTextStyles.s18w600.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconCountTextWidget(
                              icon: Icons.videocam_outlined,
                              count: countVideos.toString(),

                              // state.chapters?.chapters[courseId].videosCount
                              // .toString()
                              text: 'Videos',
                            ),
                            IconCountTextWidget(
                              icon: Icons.access_time,
                              count: houresDurtion.toString(),
                              text: 'Hours',
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconCountTextWidget(
                              icon: Icons.assignment_outlined,
                              count: countChapter.toString(),
                              text: 'Chapters',
                            ),
                            IconCountTextWidget(
                              icon: Icons.edit_note,
                              count: details.totalQuizzesCount.toString(),
                              text: 'Quizes',
                            ),
                          ],
                        ),
                      ],
                    ),
                    BlocSelector<AppManagerCubit, AppManagerState,
                        AppStateEnum>(
                      selector: (state) => state.appState,
                      builder: (context, appState) {
                        if (!isActive && appState == AppStateEnum.user) {
                          return Column(
                            children: [
                              SizedBox(height: 20.h),
                              CourseEnrollWidget(
                                courseId: courseId,
                                price: price,
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
