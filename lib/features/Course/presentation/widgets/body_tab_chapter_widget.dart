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
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_widget.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/chapter_model.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/chapter_row_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_suspended_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BodyTabChapterWidget extends StatefulWidget {
  const BodyTabChapterWidget({
    super.key,
    required this.isActive,
    required this.chapterId,
    required this.courseImage,
    required this.courseTitle,
    required this.courseId,
    required this.price,
  });
  final bool isActive;
  final int chapterId;
  final String courseImage;
  final String courseTitle;
  final int courseId;
  final String price;

  @override
  State<BodyTabChapterWidget> createState() => _BodyTabChapterWidgetState();
}

class _BodyTabChapterWidgetState extends State<BodyTabChapterWidget> {
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  void _handleFetchChapters() {
    final cubit = context.read<CourseCubit>();
    final state = cubit.state;

    // إذا عم يتم تحميل بيانات إضافية حالياً، ما نرسل طلب جديد
    if (state.loadchaptersMoreStatus == ResponseStatusEnum.loading) {
      log("Already loading more chapters, skipping request.");
      return;
    }

    // إذا لا يوجد فصول أصلاً، نحمل الصفحة الأولى
    // Check if chapters are already loaded
    if ((state.chapters == null || state.chapters!.chapters.isEmpty) && 
        state.chaptersStatus != ResponseStatusEnum.loading) {
      log("Chapters empty, fetching first page.");
      cubit.getChapters(courseId: "${widget.courseId}", reset: true, page: 1);
      return;
    }

    // تحقق من وجود صفحات إضافية
    if (!(state.chapters?.hasNextPage ?? false)) return;

    final nextPage = page + 1;
    log("Fetching more chapters, page: $nextPage");

    cubit
        .getChapters(
          courseId: "${widget.courseId}",
          reset: false,
          page: nextPage,
        )
        .then((_) {
          if (cubit.state.loadchaptersMoreStatus !=
              ResponseStatusEnum.failure) {
            page = nextPage; // تحديث رقم الصفحة بعد نجاح التحميل
            log("Page $nextPage loaded successfully.");
          } else {
            log("Failed to load page $nextPage.");
          }
        })
        .catchError((error) {
          log("Fetch chapters failed: $error");
        });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels > position.maxScrollExtent * 0.85) {
        _handleFetchChapters();
      }
    });

    // Check if chapters need to be loaded
    // Only load if they haven't been loaded yet
    final currentState = context.read<CourseCubit>().state;
    if (currentState.chaptersStatus == ResponseStatusEnum.initial || 
        (currentState.chapters == null || currentState.chapters!.chapters.isEmpty)) {
      context.read<CourseCubit>().getChapters(
        courseId: "${widget.courseId}",
        reset: true,
        page: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocSelector<AppManagerCubit, AppManagerState, AppStateEnum>(
      selector: (state) => state.appState,
      builder: (context, appState) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: BlocBuilder<CourseCubit, CourseState>(
            buildWhen: (pre, curr) =>
                pre.chapters != curr.chapters ||
                pre.chaptersStatus != curr.chaptersStatus ||
                pre.loadchaptersMoreStatus != curr.loadchaptersMoreStatus,
            builder: (context, state) {
              final chapters = state.chapters?.chapters ?? [];

              switch (state.chaptersStatus) {
                case ResponseStatusEnum.loading:
                  // Show loading only if no chapters are available yet
                  if (chapters.isEmpty) {
                    return Center(child: AppLoading.circular());
                  }
                  // If we have chapters already, continue to show them
                  return _buildChapterList(state, chapters, appState);

                case ResponseStatusEnum.failure:
                  // Show error only if no chapters are available
                  if (chapters.isEmpty) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 40.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                color: AppColors.iconError,
                                size: 40.sp,
                              ),
                              SizedBox(height: 8.h),
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
                                    courseId: "${widget.courseId}",
                                    reset: true,
                                    page: 1,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  // If we have chapters already, continue to show them
                  return _buildChapterList(state, chapters, appState);

                case ResponseStatusEnum.success:
                case ResponseStatusEnum.initial:
                  if (chapters.isEmpty) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.menu_book_outlined,
                                size: 100.r,
                                color: AppColors.iconRed,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "No Chapters",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.s20w600.copyWith(
                                  color: colors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "This course currently has no chapters available.",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.s16w400.copyWith(
                                  color: colors.textGrey,
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
                                    courseId: "${widget.courseId}",
                                    reset: true,
                                    page: 1,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return _buildChapterList(state, chapters, appState);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildChapterList(CourseState state, List<ChapterModel> chapters, AppStateEnum appState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Chapters",
          style: AppTextStyles.s18w600.copyWith(
            color: AppColors.textBlack,
          ),
        ),
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: chapters.length + 1,
            itemBuilder: (context, index) {
              if (index < chapters.length) {
                bool isChapterEnabled = false;

                if (appState == AppStateEnum.guest) {
                  isChapterEnabled = false;
                } else if (appState == AppStateEnum.user) {
                  isChapterEnabled = widget.isActive
                      ? true
                      : index < 1;
                }

                return ChapterRowWidget(
                  chapterNumber: index + 1,
                  chapterTitle: chapters[index].title,
                  videoCount: chapters[index].videosCount,
                  durationMinutes: chapters[index].totalVideoDurationMinutes ,
                  chapterState: isChapterEnabled
                      ? ChapterStateEnum.open
                      : ChapterStateEnum.locked,
                  onTap: isChapterEnabled
                      ? () {
                          log("Chapter $index pressed");
                          context.push(
                            RouteNames.chapterPage,
                            extra: {
                              "isActive": widget.isActive,
                              "courseSlug": widget.courseId
                                  .toString(),
                              "chapterId": chapters[index].id,
                              "courseTitle": widget.courseTitle,
                              "courseImage": widget.courseImage,
                              "index": index + 1,
                            },
                          );
                        }
                      : null,
                  id: chapters[index].id,
                );
              }

              // Loading more or retry for pagination
              if (state.loadchaptersMoreStatus ==
                  ResponseStatusEnum.loading) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.h),
                  child: Center(child: AppLoading.circular()),
                );
              } else if (state.loadchaptersMoreStatus ==
                  ResponseStatusEnum.failure) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    child: Column(
                      children: [
                        Icon(
                          Icons.error,
                          color: AppColors.iconError,
                          size: 40.sp,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          state.chaptersMoreError ??
                              "Failed to load more chapters",
                          style: TextStyle(
                            color: AppColors.textRed,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomButtonWidget(
                          onTap: _handleFetchChapters,
                          title: "Retry",
                          titleStyle: AppTextStyles.s14w500
                              .copyWith(
                                color: AppColors.titlePrimary,
                              ),
                          buttonColor: AppColors.buttonPrimary,
                          borderColor: AppColors.borderPrimary,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
            separatorBuilder: (context, index) => Divider(
              height: 1.h,
              color: AppColors.dividerGrey,
            ),
          ),
        ),
        if (appState == AppStateEnum.guest)
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: const CourseSuspendedWidget(),
          )
        else if (appState == AppStateEnum.user &&
            !widget.isActive)
          CourseEnrollWidget(
            courseId: widget.courseId,
            price: widget.price,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}