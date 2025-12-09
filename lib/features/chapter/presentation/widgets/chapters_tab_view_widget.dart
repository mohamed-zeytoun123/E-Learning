import 'package:e_learning/core/app/manager/app_manager_cubit.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:e_learning/features/chapter/presentation/widgets/body_tab_files_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/body_tab_quizzes_widget.dart';
import 'package:e_learning/features/chapter/presentation/widgets/body_tab_vedio_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:go_router/go_router.dart';

class ChaptersTabViewWidget extends StatelessWidget {
  final bool isActive;
  final int unlockedVideos;
  final int chapterId;

  const ChaptersTabViewWidget({
    super.key,
    required this.isActive,
    required this.chapterId,
    this.unlockedVideos = 3,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);

          return Column(
            children: [
              TabBar(
                controller: tabController,
                dividerColor: AppColors.dividerGrey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.textPrimary,
                indicatorWeight: 2.h,
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textGrey,
                labelStyle: AppTextStyles.s14w600,
                onTap: (index) {
                  if (!isActive && index != 0) {
                    tabController.index = 0;
                  }
                },
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.play_arrow, size: 20.sp),
                        SizedBox(width: 4.w),
                        Text("Videos"),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.insert_drive_file_outlined, size: 20.sp),
                        SizedBox(width: 4.w),
                        Row(
                          children: [
                            Text("Files"),
                            if (!isActive)
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: Icon(
                                  Icons.lock,
                                  size: 16.sp,
                                  color: AppColors.textGrey,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_note, size: 20.sp),
                        SizedBox(width: 4.w),
                        Row(
                          children: [
                            Text("Quizzes"),
                            if (!isActive)
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: Icon(
                                  Icons.lock,
                                  size: 16.sp,
                                  color: AppColors.textGrey,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: isActive
                      ? null
                      : const NeverScrollableScrollPhysics(),
                  children: [
                    BlocConsumer<ChapterCubit, ChapterState>(
                      listenWhen: (previous, current) =>
                          previous.videoStreamingStatus !=
                              current.videoStreamingStatus ||
                          previous.videoStreaming != current.videoStreaming,
                      buildWhen: (previous, current) =>
                          previous.videos != current.videos ||
                          previous.videosStatus != current.videosStatus,
                      listener: (context, state) {
                        if (state.videoStreamingStatus ==
                                ResponseStatusEnum.success &&
                            state.videoStreaming != null) {
                          Future.microtask(() {
                            context.push(
                              RouteNames.viedioPage,
                              extra: {
                                "chapterCubit": context.read<ChapterCubit>(),
                                "videoModel": state.videoStreaming,
                                "videoId": state.selectVideo?.id,
                              },
                            );

                            context
                                .read<ChapterCubit>()
                                .resetVideoStreamingStatus();
                          });
                        } else if (state.videoStreamingStatus ==
                            ResponseStatusEnum.failure) {
                          AppMessage.showFlushbar(
                            context: context,
                            backgroundColor: AppColors.messageError,
                            message:
                                state.videoStreamingError ??
                                "Failed to load video",
                            title: "Error",
                            isShowProgress: true,
                            iconData: Icons.error_outline_outlined,
                            iconColor: AppColors.iconWhite,
                          );
                        }
                      },
                      builder: (context, state) {
                        return BodyTabVedioWidget(
                          isActive: isActive,
                          onVideoTap: (index) {
                            if (isActive || index < unlockedVideos) {
                              final video = state.videos?.videos?[index];
                              if (video != null) {
                                context.read<ChapterCubit>().setSelectedVideo(
                                  video,
                                );
                                context.read<ChapterCubit>().getSecureVideo(
                                  videoId: video.id.toString(),
                                );
                              }
                            }
                          },
                          chapterId: chapterId,
                        );
                      },
                    ),

                    BodyTabFilesWidget(
                      onFileTap: (index) async {
                        if (isActive) {
                          final attachment = context
                              .read<ChapterCubit>()
                              .state
                              .attachments?[index];

                          if (attachment != null) {
                            try {
                              await context
                                  .read<ChapterCubit>()
                                  .downloadAttachmentWithProgress(
                                    attachmentId: attachment.id,
                                    token: context
                                        .read<AppManagerCubit>()
                                        .state
                                        .token,
                                    fileName: attachment.fileName,
                                    fileUrl: attachment.fileUrl,
                                  );
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Failed to download file: $e',
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          }
                        }
                      },
                    ),

                    // الاختبارات
                    BodyTabQuizzesWidget(chapterId: chapterId),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
