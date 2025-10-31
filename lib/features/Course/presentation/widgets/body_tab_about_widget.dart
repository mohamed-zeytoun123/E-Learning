import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/error/error_state_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/course/presentation/manager/course_state.dart';
import 'package:e_learning/features/course/presentation/widgets/course_enroll_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/icon_count_text_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/price_text_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/teacher_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabAboutWidget extends StatelessWidget {
  const BodyTabAboutWidget({
    super.key,
    required this.isActive,
    required this.courseSlug,
  });
  final bool isActive;
  final String courseSlug;

  @override
  Widget build(BuildContext context) {
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
                context.read<CourseCubit>().getCourseDetails(slug: courseSlug);
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
                            slug: courseSlug,
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
                        color: AppColors.textBlack,
                      ),
                    ),
                    TeacherRowWidget(
                      teacherName: details.teacherName,
                      teacherImageUrl: "", //todo image is not exist
                    ),
                    Divider(
                      color: AppColors.dividerGrey,
                      thickness: 1,
                      height: 0.h,
                    ),

                    Text(
                      "About The Course",
                      style: AppTextStyles.s18w600.copyWith(
                        color: AppColors.textBlack,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      details.description,
                      style: AppTextStyles.s16w400.copyWith(
                        color: AppColors.textBlack,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Paid Price",
                          style: AppTextStyles.s16w600.copyWith(
                            color: AppColors.textBlack,
                          ),
                        ),
                        PriceTextWidget(price: details.price),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Divider(
                        color: AppColors.dividerGrey,
                        thickness: 1,
                        height: 0.h,
                      ),
                    ),
                    Text(
                      "Content",
                      style: AppTextStyles.s18w600.copyWith(
                        color: AppColors.textBlack,
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
                              count: 20.toString(),
                              text: 'Hours',
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconCountTextWidget(
                              icon: Icons.assignment_outlined,
                              count: 10.toString(),
                              text: 'Chapters',
                            ),
                            IconCountTextWidget(
                              icon: Icons.edit_note,
                              count: 10.toString(),
                              text: 'Quizes',
                            ),
                          ],
                        ),
                      ],
                    ),

                    BlocSelector<
                      AppManagerCubit,
                      AppManagerState,
                      AppStateEnum
                    >(
                      selector: (state) => state.appState,
                      builder: (context, appState) {
                        if (!isActive && appState == AppStateEnum.user) {
                          return Column(
                            children: [
                              SizedBox(height: 20.h),
                              CourseEnrollWidget(),
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
