import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/di/service_locator.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/widgets/custom_cached_image_widget.dart';
import 'package:e_learning/features/chapter/data/source/local/chapter_local_data_source.dart';
import 'package:e_learning/features/chapter/data/source/repo/chapter_repository.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:e_learning/features/chapter/presentation/widgets/chapter_title_sub_title_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/chapters_tab_view_widget.dart';
import 'package:e_learning/features/course/presentation/widgets/custom_app_bar_course_widget.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChapterPage extends StatelessWidget {
  const ChapterPage({
    super.key,
    required this.isActive,
    required this.courseSlug,
    required this.chapterId,
    required this.courseImage,
    required this.courseTitle,
    required this.index,
  });

  final bool isActive;
  final String courseSlug;
  final int chapterId;
  final int index;
  final String? courseImage;
  final String courseTitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChapterCubit>(
      create: (context) => ChapterCubit(
        repo: di<ChapterRepository>(),
        local: di<ChapterLocalDataSource>(),
      )..getChapterById(courseSlug: courseSlug, chapterId: chapterId),
      child: BlocBuilder<ChapterCubit, ChapterState>(
        buildWhen: (pre, curr) => pre.chaptersStatus != curr.chaptersStatus,
        builder: (context, state) {
          Widget bodyContent;

          switch (state.chaptersStatus) {
            case ResponseStatusEnum.loading:
              bodyContent = Center(child: AppLoading.circular());
              break;

            case ResponseStatusEnum.failure:
              bodyContent = Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 40.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.chaptersError ?? "Something went wrong",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textError,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        title: "Retry",
                        buttonColor: AppColors.buttonPrimary,
                        textColor: AppColors.titlePrimary,
                        onTap: () {
                          context.read<ChapterCubit>().getChapterById(
                                courseSlug: courseSlug,
                                chapterId: chapterId,
                              );
                        },
                      ),
                    ],
                  ),
                ),
              );
              break;

            case ResponseStatusEnum.success:
            case ResponseStatusEnum.initial:
              bodyContent = CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 262.h,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: AppColors.backgroundPage,
                    flexibleSpace: FlexibleSpaceBar(
                      background: CustomCachedImageWidget(
                        appImage:
                            courseImage ?? "",
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 262,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChapterTitleSubTitleWidget(
                          quizText: state.chapter?.quizCount.toString() ?? "0",
                          durationText:
                              state.chapter?.totalVideoDurationMinutes
                                  .toString() ??
                              '0',
                          title: '$index ${state.chapter?.title ?? ""}',
                          videosText:
                              state.chapter?.totalVideosCount.toString() ?? "0",
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    child: ChaptersTabViewWidget(
                      isActive: isActive,
                      chapterId: chapterId,
                    ),
                  ),
                ],
              );
              break;
          }

          return Scaffold(
            backgroundColor: AppColors.backgroundPage,
            appBar: CustomAppBarCourseWidget(
              title: courseTitle,
              showBack: true,
            ),
            body: bodyContent,
          );
        },
      ),
    );
  }
}
