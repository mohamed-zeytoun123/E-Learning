import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:e_learning/features/chapter/presentation/widgets/video_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyTabVedioWidget extends StatefulWidget {
  final bool isActive;
  final int unlockedVideos;
  final Function(int index)? onVideoTap;
  final int chapterId;

  const BodyTabVedioWidget({
    super.key,
    this.isActive = false,
    this.unlockedVideos = 3,
    this.onVideoTap,
    required this.chapterId,
  });

  @override
  State<BodyTabVedioWidget> createState() => _BodyTabVedioWidgetState();
}

class _BodyTabVedioWidgetState extends State<BodyTabVedioWidget> {
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  void _handleFetchMore() {
    final cubit = context.read<ChapterCubit>();
    final state = cubit.state;

    // إذا قيد التحميل أو لا يوجد بيانات أو hasNextPage == false
    if (state.videosMoreStatus == ResponseStatusEnum.loading) return;
    if ((state.videos?.videos?.isEmpty ?? true)) return;
    if (state.videos?.hasNextPage == false) return;

    final nextPage = page + 1;

    cubit
        .getVideos(chapterId: widget.chapterId, reset: false, page: nextPage)
        .then((_) {
          if (cubit.state.videosMoreStatus != ResponseStatusEnum.failure) {
            page = nextPage;
          }
        });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels > position.maxScrollExtent * 0.85) {
        _handleFetchMore();
      }
    });

    context.read<ChapterCubit>().getVideos(
      chapterId: widget.chapterId,
      reset: true,
      page: 1,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChapterCubit, ChapterState>(
      buildWhen: (prev, curr) =>
          prev.videos != curr.videos ||
          prev.videosMoreStatus != curr.videosMoreStatus,
      builder: (context, state) {
        final videos = state.videos?.videos ?? [];

        if (state.videosStatus == ResponseStatusEnum.loading && page == 1) {
          return Center(child: AppLoading.circular());
        }

        // Check for empty videos list (professional empty state)
        if (state.videosStatus == ResponseStatusEnum.success &&
            videos.isEmpty &&
            page == 1) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_library_outlined,
                    color: AppColors.iconGrey.withOpacity(0.5),
                    size: 50.sp,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "No videos available",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "There are currently no videos in this chapter",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textGrey.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.videosStatus == ResponseStatusEnum.failure &&
                state.videosError!.contains("No Data") ||
            state.videos?.videos!.isEmpty == true) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_library_outlined,
                    size: 48.sp,
                    color: AppColors.iconGrey.withOpacity(0.5),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "No videos available",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s16w600.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Please check again later",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s14w400.copyWith(
                      color: AppColors.textGrey.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Check for error state
        if (state.videosStatus == ResponseStatusEnum.failure && page == 1) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: AppColors.iconError,
                    size: 50.sp,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    state.videosError ?? "Failed to load videos",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.s14w600.copyWith(
                      color: AppColors.textError,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomButtonWidget(
                    title: "Retry",
                    titleStyle: AppTextStyles.s14w500.copyWith(
                      color: AppColors.textWhite,
                    ),
                    buttonColor: AppColors.buttonPrimary,
                    borderColor: AppColors.borderPrimary,
                    onTap: () {
                      context.read<ChapterCubit>().getVideos(
                        chapterId: widget.chapterId,
                        reset: true,
                        page: 1,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          physics: const BouncingScrollPhysics(),
          itemCount: videos.length + 1,
          itemBuilder: (context, index) {
            if (index < videos.length) {
              final isVideoEnabled =
                  widget.isActive || index < widget.unlockedVideos;
              final video = videos[index];

              return InkWell(
                onTap: isVideoEnabled
                    ? () {
                        if (widget.onVideoTap != null) {
                          widget.onVideoTap!(index);
                        }
                      }
                    : null,
                child: VideoRowWidget(
                  videoId: video.id.toString(),
                  chapterTitle: video.title,
                  durationSecond: video.duration,
                  completedVideos: video.progressPercentage,
                  isLocked: !isVideoEnabled,
                  onTap: isVideoEnabled
                      ? () {
                          if (widget.onVideoTap != null) {
                            widget.onVideoTap!(index);
                          }
                        }
                      : null,
                ),
              );
            } else {
              // Loader أو رسالة النهاية أو فشل التحميل الإضافي
              if (state.videosMoreStatus == ResponseStatusEnum.loading) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(child: AppLoading.circular()),
                );
              } else if (state.videosMoreStatus == ResponseStatusEnum.failure) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 100.h),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.textRed,
                            size: 40.sp,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            state.videosMoreError ??
                                "Failed to load more videos",
                            style: AppTextStyles.s14w600.copyWith(
                              color: AppColors.textError,
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state.videos?.hasNextPage == true) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Center(child: AppLoading.circular()),
                );
              } else {
                return const SizedBox.shrink();
              }
            }
          },
          separatorBuilder: (_, __) =>
              Divider(height: 1.h, color: AppColors.dividerGrey),
        );
      },
    );
  }
}
