import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/theme/typography.dart';
import 'package:e_learning/features/Video/data/functions/open_comments_sheet.dart';

import 'package:e_learning/features/Video/data/models/video_stream_model.dart';
import 'package:e_learning/features/chapter/data/models/download_item.dart';
import 'package:e_learning/features/chapter/data/models/video_model.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/features/Video/presentation/widgets/bootom_sheet_settings_widget.dart';


class VideoPlayingPage extends StatefulWidget {
  //?-----------------------------------------------------
  final VideoStreamModel? videoModel;
  final void Function(Duration)? onPositionChanged;
  final File? videoFile;

  //?-----------------------------------------------------
  const VideoPlayingPage({
    super.key,
    this.onPositionChanged,
    this.videoModel,
    this.videoFile,
  }) : assert(
         videoModel != null || videoFile != null,
         "Either videoModel or videoFile must be provided",
       );
  //?-----------------------------------------------------
  @override
  State<VideoPlayingPage> createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;
  double _currentSpeed = 1.0;
  bool _videoError = false;

  //?-----------------------------------------------------
  //* Init State
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    try {
      if (widget.videoFile != null) {
        _videoController = VideoPlayerController.file(widget.videoFile!);
      } else if (widget.videoModel != null) {
        _videoController = VideoPlayerController.network(
          widget.videoModel!.secureStreamingUrl,
        );
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Video file not found")));
          Navigator.pop(context);
        });
        _videoError = true;
        return;
      }

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        showControls: true,
        showOptions: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blueAccent,
          handleColor: Colors.blue,
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white54,
        ),
      );

      _videoController.addListener(() {
        if (widget.onPositionChanged != null) {
          widget.onPositionChanged!(_videoController.value.position);
        }
        setState(() {});
      });

      _videoController.initialize().then((_) => setState(() {}));
      _chewieController.addListener(() => setState(() {}));
    } catch (e) {
      debugPrint("Video initialization failed: $e");
      _videoError = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Video file not found")));
        Navigator.pop(context);
      });
    }
  }

  //?-----------------------------------------------------
  //* Dispose
  @override
  void dispose() {
    if (!_videoError) {
      _videoController.dispose();
      _chewieController.dispose();
    }
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
  //?-----------------------------------------------------

  void openSettingsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return BootomSheetSettingsWidget(
          currentSpeed: _currentSpeed,
          onSpeedSelected: (newSpeed) {
            setState(() {
              _currentSpeed = newSpeed;
              if (!_videoError) _videoController.setPlaybackSpeed(newSpeed);
            });
          },
        );
      },
    );
  }

  void _downloadCurrentVideo() {
    final video = context.read<ChapterCubit>().state.selectVideo;
    if (video == null) return;

    final fileName = "${video.title.replaceAll(' ', '_')}.mp4";

    context.read<ChapterCubit>().downloadVideo(
      videoId: video.id.toString(),
      fileName: fileName,
    );
  }

  //?-----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final chapterState = context.watch<ChapterCubit>().state;
    final selectedVideo = chapterState.selectVideo;

    // For cached videos, we might not have a selectedVideo, but we can try to find it
    // by looking at the videoFile name or other identifying information
    VideoModel? displayVideo = selectedVideo;

    // If we're playing a cached video and don't have a selectedVideo,
    // we still want to show the UI elements
    bool isPlayingCachedVideo =
        widget.videoFile != null && selectedVideo == null;

    // For cached videos, we should hide UI icons according to user preference
    bool shouldHideUIIcons = isPlayingCachedVideo;

    return Scaffold(
      backgroundColor: Colors.black,
      body: _videoError
          ? Center(
              child: Text(
                "Cannot play this video",
                style: AppTextStyles.s16w400.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            )
          : _videoController.value.isInitialized
          ? Stack(
              children: [
                Center(child: Chewie(controller: _chewieController)),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      color: Colors.black.withOpacity(0.3),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (_chewieController.isFullScreen) {
                                _chewieController.exitFullScreen();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Show video details if we have a selected video
                                    if (selectedVideo != null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            VideoDetailsDialogWidget(
                                              video: selectedVideo,
                                            ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    selectedVideo?.title ??
                                        widget.videoFile?.path
                                            .split('/')
                                            .last ??
                                        "Video Full Title",
                                    style: AppTextStyles.s16w600.copyWith(
                                      color: AppColors.textWhite,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                2.sizedH,
                                Text(
                                  selectedVideo?.storageType ?? "Course Name",
                                  style: AppTextStyles.s12w400.copyWith(
                                    color: AppColors.textGrey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          8.sizedW,

                          //?------------------------------------------------------------
                          // Show download button only if not playing from cache
                          if (!shouldHideUIIcons) ...[
                            // Always show download button, even for cached videos
                            BlocBuilder<ChapterCubit, ChapterState>(
                              buildWhen: (previous, current) =>
                                  previous.downloads != current.downloads,
                              builder: (context, state) {
                                // Try to find the video in state, or use selectedVideo
                                final video = state.selectVideo ?? displayVideo;

                                // If we don't have a video but are playing a cached file,
                                // we still show the download UI
                                if (video == null && !isPlayingCachedVideo) {
                                  return const SizedBox();
                                }

                                // Find download item for this video or create a default one
                                DownloadItem downloadItem;
                                bool isVideoCached = false;

                                if (video != null) {
                                  downloadItem = state.downloads.firstWhere(
                                    (d) => d.videoId == video.id.toString(),
                                    orElse: () => DownloadItem(
                                      videoId: video.id.toString(),
                                      fileName: "",
                                      isDownloading: false,
                                      progress: 0.0,
                                    ),
                                  );

                                  // Check if video is cached
                                  isVideoCached = state.downloads.any(
                                    (d) =>
                                        d.videoId == video.id.toString() &&
                                        d.isCompleted,
                                  );
                                } else {
                                  // For cached videos without a selected video,
                                  // we create a default completed download item
                                  downloadItem = DownloadItem(
                                    videoId:
                                        "", // We don't have the ID for cached videos
                                    fileName: "",
                                    isDownloading: false,
                                    isCompleted: isPlayingCachedVideo,
                                    progress: 1.0,
                                  );
                                  isVideoCached = isPlayingCachedVideo;
                                }

                                // If video is cached, show checkmark icon
                                if (isVideoCached) {
                                  return const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 28,
                                  );
                                }

                                if (downloadItem.isDownloading) {
                                  return SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          value: downloadItem.progress == 0.0
                                              ? null
                                              : downloadItem.progress,
                                          color: Colors.blueAccent,
                                        ),
                                        // Show progress percentage
                                        Text(
                                          '${(downloadItem.progress * 100).toInt()}%',
                                          style: AppTextStyles.s12w400.copyWith(
                                            color: AppColors.textWhite,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (downloadItem.isCompleted) {
                                  // ✅ علامة صح بدل أيقونة التحميل
                                  return const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 28,
                                  );
                                } else if (downloadItem.hasError) {
                                  return IconButton(
                                    icon: const Icon(
                                      Icons.download,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      if (video != null) {
                                        context.read<ChapterCubit>().downloadVideo(
                                          videoId: video.id.toString(),
                                          fileName:
                                              "${video.title.replaceAll(' ', '_')}.mp4",
                                        );
                                        
                                        // Show a snackbar to indicate retry
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Retrying download...'),
                                              backgroundColor: Colors.blue,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  );
                                } else {
                                  // For non-cached videos, show download button
                                  return IconButton(
                                    icon: const Icon(
                                      Icons.download,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      if (video != null) {
                                        final cubit = context
                                            .read<ChapterCubit>();
                                        final vid = video.id.toString();
                                        if (await cubit.isVideoCachedById(
                                          vid,
                                        )) {
                                          // Video is already cached, don't do anything
                                          return;
                                        }
                                        cubit.downloadVideo(
                                          videoId: vid,
                                          fileName:
                                              "${video.title.replaceAll(' ', '_')}.mp4",
                                        );
                                        
                                        // Show a snackbar to indicate download started
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Starting download...'),
                                              backgroundColor: Colors.blue,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                          //?------------------------------------------------------------
                          // Show comment and settings icons only if not playing from cache
                          if (!shouldHideUIIcons) ...[
                            IconButton(
                              icon: const Icon(
                                Icons.messenger_outline,
                                color: Colors.white,
                              ),
                              onPressed: () => openCommentsSheet(context),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              onPressed: openSettingsSheet,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(child: AppLoading.circular()),
    );
  }
}

class VideoDetailsDialogWidget extends StatelessWidget {
  final VideoModel video;

  const VideoDetailsDialogWidget({super.key, required this.video});

  String _formatDuration(int seconds) {
    final d = Duration(seconds: seconds);
    String two(int n) => n.toString().padLeft(2, '0');
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    return h > 0 ? '${two(h)}:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // خلفية شفافة مع إغلاق عند الضغط
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(color: Colors.black54),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s18w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  6.sizedH,
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 18, color: Colors.black54),
                      6.sizedW,
                      Text(
                        _formatDuration(video.duration),
                        style: AppTextStyles.s14w400.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                      16.sizedW,
                      const Icon(
                        Icons.storage,
                        size: 18,
                        color: Colors.black54,
                      ),
                      6.sizedW,
                      Text(
                        video.storageType,
                        style: AppTextStyles.s14w400.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                  if (video.description.isNotEmpty) ...[
                    10.sizedH,
                    Text(
                      video.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s14w400.copyWith(
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                  12.sizedH,
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<ChapterCubit>().downloadVideo(
                            videoId: video.id.toString(),
                            fileName: "${video.title.replaceAll(' ', '_')}.mp4",
                          );
                          Navigator.pop(context);
                          
                          // Show a snackbar to indicate download started
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Starting download...'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Download'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
