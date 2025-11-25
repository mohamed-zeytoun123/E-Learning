import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/app/manager/app_manager_state.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/theme_extensions.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/manager/course_state.dart';
import 'package:e_learning/features/Course/presentation/widgets/chapter_row_widget.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_enroll_widget.dart';
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
      return;
    }

    // إذا لا يوجد فصول أصلاً، نحمل الصفحة الأولى
    if (state.chapters == null || state.chapters!.chapters.isEmpty) {
      cubit.getChapters(courseId: "${widget.courseId}", reset: true, page: 1);
      return;
    }

    // تحقق من وجود صفحات إضافية
    if (!(state.chapters?.hasNextPage ?? false)) return;

    final nextPage = page + 1;

    cubit
        .getChapters(
      courseId: "${widget.courseId}",
      reset: false,
      page: nextPage,
    )
        .then((_) {
      if (cubit.state.loadchaptersMoreStatus != ResponseStatusEnum.failure) {
        page = nextPage; // تحديث رقم الصفحة بعد نجاح التحميل
      }
    }).catchError((error) {
      // Error handled silently
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

    // تحميل الصفحة الأولى تلقائي عند init
    context.read<CourseCubit>().getChapters(
          courseId: "${widget.courseId}",
          reset: true,
          page: 1,
        );
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
                  return Center(child: AppLoading.circular());

                case ResponseStatusEnum.failure:
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
                            8.sizedH,
                            Text(
                              state.chaptersError ?? "Something went wrong",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.s20w600.copyWith(
                                color: AppColors.textError,
                              ),
                            ),
                            30.sizedH,
                            CustomButton(
                              title: "Retry",
                              buttonColor: AppColors.buttonPrimary,
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
                                color: AppColors.iconOrange,
                              ),
                              20.sizedH,
                              Text(
                                "No Chapters",
                                textAlign: TextAlign.center,
                                style: AppTextStyles.s20w600.copyWith(
                                  color: AppColors.textBlack,
                                ),
                              ),
                              10.sizedH,
                              Text(
                                "This course currently has no chapters available.",
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

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chapters",
                        style: AppTextStyles.s18w600
                            .copyWith(color: context.colors.textPrimary),
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
                                isChapterEnabled =
                                    widget.isActive ? true : index < 1;
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
                                        context.push(
                                          RouteNames.chapterPage,
                                          extra: {
                                            "isActive": widget.isActive,
                                            "courseSlug":
                                                widget.courseId.toString(),
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
                                      8.sizedH,
                                      Text(
                                        state.chaptersMoreError ??
                                            "Failed to load more chapters",
                                        style: TextStyle(
                                          color: AppColors.textRed,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      10.sizedH,
                                      CustomButton(
                                        onTap: _handleFetchChapters,
                                        title: "Retry",
                                        buttonColor: AppColors.buttonPrimary,
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
                            color: colors.dividerGrey,
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
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
