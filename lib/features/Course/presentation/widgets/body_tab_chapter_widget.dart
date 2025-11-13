import 'dart:developer';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/model/enums/app_state_enum.dart';
import 'package:e_learning/core/model/enums/chapter_state_enum.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/chapter_row_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_suspended_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BodyTabChapterWidget extends StatelessWidget {
  const BodyTabChapterWidget({
    super.key,
    required this.isActive,
    required this.courseSlug,
    required this.chapterId,
    required this.courseImage,
    required this.courseTitle,
  });
  final bool isActive;
  final String courseSlug;
  final int chapterId;
  final String courseImage;
  final String courseTitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocSelector<AppManagerCubit, AppManagerState, AppStateEnum>(
      selector: (state) => state.appState,
      builder: (context, appState) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: BlocBuilder<CourseCubit, CourseState>(
            buildWhen: (pre, curr) => pre.chaptersStatus != curr.chaptersStatus,
            builder: (context, state) {
              switch (state.chaptersStatus) {
                case ResponseStatusEnum.loading:
                  return Center(child: AppLoading.circular());

                case ResponseStatusEnum.failure:
                  {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 40.h,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.chaptersError ?? "Something went wrong",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.s20w600.copyWith(
                                  color: AppColors.textError,
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
                                  context.read<CourseCubit>().getChapters(
                                    courseSlug: courseSlug,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                case ResponseStatusEnum.success:
                case ResponseStatusEnum.initial:
                  final chapters = state.chapters;

                  if (chapters == null || chapters.isEmpty) {
                    return SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.menu_book_outlined,
                                size: 100.r,
                                color: AppColors.iconOrange,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "No Chapters",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.s20w600.copyWith(
                                  color: AppColors.textBlack,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "This course currently has no chapters available.",
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
                                  context.read<CourseCubit>().getChapters(
                                    courseSlug: courseSlug,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chapters",
                        style: AppTextStyles.s18w600.copyWith(
                          color: context.colors.textPrimary
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: chapters.length,
                          itemBuilder: (context, index) {
                            bool isChapterEnabled = false;

                            if (appState == AppStateEnum.guest) {
                              isChapterEnabled = false;
                            } else if (appState == AppStateEnum.user) {
                              isChapterEnabled = isActive ? true : index < 1;
                            }

                            return ChapterRowWidget(
                              chapterNumber: index + 1,
                              chapterTitle: chapters[index].title,
                              videoCount: 4,
                              durationMinutes: 126,
                              chapterState: isChapterEnabled
                                  ? ChapterStateEnum.open
                                  : ChapterStateEnum.locked,
                              onTap: isChapterEnabled
                                  ? () {
                                      log("Chapter $index pressed");
                                      context.push(
                                        RouteNames.chapterPage,
                                        extra: {
                                          "isActive": isActive,
                                          "courseSlug": courseSlug, // صححت
                                          "chapterId":
                                              chapters[index].id, // صححت
                                          "courseTitle": courseTitle,
                                          "courseImage": courseImage,
                                          "index": index + 1,
                                        },
                                      );
                                    }
                                  : null,
                              id: chapters[index].id,
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            height: 1.h,
                            color: colors.dividerGrey,
                          ),
                        ),
                      ),
                      if (appState == AppStateEnum.guest)
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: const CourseSuspendedWidget(),
                        )
                      else if (appState == AppStateEnum.user && !isActive)
                        const CourseEnrollWidget()
                      else
                        const SizedBox.shrink(),
                    ],
                  );
              }
            },
          ),
        );
      },
    );
  }
}
