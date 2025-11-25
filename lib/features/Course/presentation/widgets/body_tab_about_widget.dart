import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/error_state_widget.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_widget.dart';
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
    required this.houresDurtion,
  });
  final bool isActive;
  final int courseId;
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
                      20.sizedH,
                      Text(
                        "No Course Data",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.s20w600.copyWith(
                          color: AppColors.textBlack,
                        ),
                      ),
                      10.sizedH,
                      Text(
                        "There is currently no information available for this course.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.s16w400.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                      30.sizedH,
                      CustomButton(
                        title: "Retry",
                        buttonColor: AppColors.buttonPrimary,
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
                    8.sizedH,
                    Text(
                      details.description,
                      style: AppTextStyles.s16w400.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    16.sizedH,
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
                              count: 28.toString(),
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
                              count: state.chapters != null
                                  ? state.chapters!.chapters.length.toString()
                                  : "0",
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
                              20.sizedH,
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
