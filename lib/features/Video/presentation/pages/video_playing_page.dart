import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:e_learning/core/asset/app_icons.dart';
import 'package:e_learning/features/Video/data/functions/get_hls_qualities.dart';
import 'package:e_learning/features/Video/data/functions/open_comments_sheet.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/download_item.dart';
import 'package:e_learning/features/chapter/data/models/video_models/video_model.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/Video/presentation/widgets/bootom_sheet_settings_widget.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/colors/app_colors.dart';

class VideoPlayingPage extends StatefulWidget {
  final VideoStreamModel videoModel;
  final void Function(Duration)? onPositionChanged;
  final int? videoId;

  const VideoPlayingPage({
    super.key,
    required this.videoModel,
    this.onPositionChanged,
    this.videoId,
  });

  @override
  State<VideoPlayingPage> createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;
  double _currentSpeed = 1.0;
  bool _videoError = false;
  String _currentQuality = "AUTO";

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    try {
      _videoController =
          VideoPlayerController.networkUrl(
              Uri.parse(widget.videoModel.secureStreamingUrl),
              videoPlayerOptions: VideoPlayerOptions(
                allowBackgroundPlayback: false,
                mixWithOthers: false,
              ),
              formatHint: VideoFormat.hls,
            )
            ..setLooping(false)
            ..setVolume(1.0)
            ..setPlaybackSpeed(_currentSpeed);

      loadVideoQualities();

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        autoInitialize: false,
        looping: false,
        allowFullScreen: true,
        showControls: true,
        showOptions: false,
        zoomAndPan: false,
        allowMuting: true,
        allowPlaybackSpeedChanging: false,
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

      _chewieController.addListener(() => setState(() {}));
    } catch (e) {
      debugPrint("Video initialization failed: $e");
      _videoError = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMessage.showFlushbar(
          context: context,
          title: "Error",
          message: "Video file not found",
          backgroundColor: AppColors.messageError,
          iconData: Icons.error_outline,
          iconColor: AppColors.iconWhite,
          isShowProgress: true,
        );

        Navigator.pop(context);
      });
    }
  }

  Future<void> loadVideoQualities() async {
    try {
      final qualities = await getHLSQualities(
        widget.videoModel.secureStreamingUrl,
      );

      if (qualities.isNotEmpty) {
        setState(() {
          widget.videoModel.qualities?.addAll(qualities);
          widget.videoModel.qualities ??= qualities;
        });
      }
    } catch (e) {
      debugPrint("Failed to load qualities: $e");
    }
  }

  @override
  void dispose() {
    if (!_videoError) {
      _videoController.dispose();
      _chewieController.dispose();
    }
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

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
          initialQuality: _currentQuality,
          qualities:
              widget.videoModel.qualities ??
              {"AUTO": widget.videoModel.secureStreamingUrl},
          onQualitySelected: (url) async {
            if (!_videoError) {
              final currentPosition = _videoController.value.position;

              try {
                await _videoController.pause();
                await _videoController.dispose();

                _videoController = VideoPlayerController.networkUrl(
                  Uri.parse(url),
                  videoPlayerOptions: VideoPlayerOptions(
                    allowBackgroundPlayback: false,
                    mixWithOthers: false,
                  ),
                  formatHint: VideoFormat.hls,
                );

                await _videoController.initialize();
                await _videoController.seekTo(currentPosition);
                await _videoController.setPlaybackSpeed(_currentSpeed);

                setState(() {
                  _currentQuality =
                      widget.videoModel.qualities?.entries
                          .firstWhere(
                            (entry) => entry.value == url,
                            orElse: () => MapEntry("AUTO", url),
                          )
                          .key ??
                      "AUTO";
                });

                _chewieController.dispose();

                _chewieController = ChewieController(
                  allowPlaybackSpeedChanging: false,
                  showOptions: false,
                  videoPlayerController: _videoController,
                  autoPlay: true,
                  autoInitialize: true,
                  looping: false,
                  allowFullScreen: true,
                  showControls: true,
                  allowMuting: true,
                  materialProgressColors: ChewieProgressColors(
                    playedColor: Colors.blueAccent,
                    handleColor: Colors.blue,
                    backgroundColor: Colors.white24,
                    bufferedColor: Colors.white54,
                  ),
                );
              } catch (e) {
                debugPrint("Error changing video quality: $e");
                AppMessage.showFlushbar(
                  context: context,
                  title: "Error",
                  message: "Cannot change video quality",
                  backgroundColor: AppColors.messageError,
                  iconData: Icons.error_outline,
                  iconColor: AppColors.iconWhite,
                  isShowProgress: true,
                );
              }
            }
          },
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

  @override
  Widget build(BuildContext context) {
    final chapterState = context.watch<ChapterCubit>().state;
    final selectedVideo = chapterState.selectVideo;

    VideoModel? displayVideo = selectedVideo;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.iconWhite,
                              ),
                              onPressed: () {
                                int seconds =
                                    _videoController.value.position.inSeconds;

                                context
                                    .read<ChapterCubit>()
                                    .updateVideoProgress(
                                      videoId: selectedVideo?.id ?? 0,
                                      watchedSeconds: seconds,
                                    );

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
                                  Text(
                                    selectedVideo?.title ?? "Video Full Title",
                                    style: AppTextStyles.s16w600.copyWith(
                                      color: AppColors.textWhite,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    selectedVideo?.chapterName ??
                                        "Chapter Name",
                                    style: AppTextStyles.s12w400.copyWith(
                                      color: AppColors.textGrey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.h),
                            BlocListener<ChapterCubit, ChapterState>(
                              listenWhen: (previous, current) =>
                                  previous.downloads != current.downloads,
                              listener: (context, state) {
                                for (var d in state.downloads) {
                                  if (d.hasError) {
                                    AppMessage.showFlushbar(
                                      context: context,
                                      title: "Error",
                                      message:
                                          d.errorMessage ?? "Download failed",
                                      backgroundColor: AppColors.messageError,
                                      iconData: Icons.error_outline,
                                      iconColor: AppColors.iconWhite,
                                      isShowProgress: true,
                                    );
                                  }
                                }
                              },
                              child: BlocBuilder<ChapterCubit, ChapterState>(
                                buildWhen: (previous, current) =>
                                    previous.downloads != current.downloads,
                                builder: (context, state) {
                                  final video =
                                      state.selectVideo ?? displayVideo;

                                  DownloadItem downloadItem = state.downloads
                                      .firstWhere(
                                        (d) =>
                                            d.videoId == video?.id.toString(),
                                        orElse: () => DownloadItem(
                                          videoId: video?.id.toString() ?? "",
                                          fileName: "",
                                          isDownloading: false,
                                          progress: 0.0,
                                        ),
                                      );

                                  bool isCached = state.downloads.any(
                                    (d) =>
                                        d.videoId == video?.id.toString() &&
                                        d.isCompleted,
                                  );

                                  if (isCached) {
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
                                          Text(
                                            '${(downloadItem.progress * 100).toInt()}%',
                                            style: AppTextStyles.s12w400
                                                .copyWith(
                                                  color: AppColors.textWhite,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  // Show red download icon if hasError
                                  if (downloadItem.hasError) {
                                    return IconButton(
                                      icon: const Icon(
                                        Icons.download,
                                        color: Colors.red,
                                      ),
                                      tooltip: "Download failed. Tap to retry.",
                                      onPressed: () async {
                                        if (video != null) {
                                          final cubit = context
                                              .read<ChapterCubit>();
                                          final vid = video.id.toString();
                                          cubit.downloadVideo(
                                            videoId: vid,
                                            fileName:
                                                "${video.title.replaceAll(' ', '_')}.mp4",
                                          );
                                        }
                                      },
                                    );
                                  }

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
                                          AppMessage.showFlushbar(
                                            context: context,
                                            title: "Info",
                                            message: 'Video already downloaded',
                                            backgroundColor:
                                                AppColors.messageInfo,
                                            iconData: Icons.check_circle,
                                            iconColor: AppColors.iconWhite,
                                            isShowProgress: true,
                                            duration: const Duration(
                                              seconds: 4,
                                            ),
                                          );
                                          return;
                                        }

                                        cubit.downloadVideo(
                                          videoId: vid,
                                          fileName:
                                              "${video.title.replaceAll(' ', '_')}.mp4",
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ),

                            // BlocBuilder<ChapterCubit, ChapterState>(
                            //   buildWhen: (previous, current) =>
                            //       previous.downloads != current.downloads,
                            //   builder: (context, state) {
                            //     final video = state.selectVideo ?? displayVideo;

                            //     DownloadItem downloadItem = state.downloads
                            //         .firstWhere(
                            //           (d) => d.videoId == video?.id.toString(),
                            //           orElse: () => DownloadItem(
                            //             videoId: video?.id.toString() ?? "",
                            //             fileName: "",
                            //             isDownloading: false,
                            //             progress: 0.0,
                            //           ),
                            //         );

                            //     bool isCached = state.downloads.any(
                            //       (d) =>
                            //           d.videoId == video?.id.toString() &&
                            //           d.isCompleted,
                            //     );

                            //     if (isCached) {
                            //       return const Icon(
                            //         Icons.check_circle,
                            //         color: Colors.green,
                            //         size: 28,
                            //       );
                            //     }

                            //     if (downloadItem.isDownloading) {
                            //       return SizedBox(
                            //         width: 40,
                            //         height: 40,
                            //         child: Stack(
                            //           alignment: Alignment.center,
                            //           children: [
                            //             CircularProgressIndicator(
                            //               value: downloadItem.progress == 0.0
                            //                   ? null
                            //                   : downloadItem.progress,
                            //               color: Colors.blueAccent,
                            //             ),
                            //             Text(
                            //               '${(downloadItem.progress * 100).toInt()}%',
                            //               style: AppTextStyles.s12w400.copyWith(
                            //                 color: AppColors.textWhite,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     }

                            //     return IconButton(
                            //       icon: const Icon(
                            //         Icons.download,
                            //         color: Colors.white,
                            //       ),
                            //       onPressed: () async {
                            //         if (video != null) {
                            //           final cubit = context
                            //               .read<ChapterCubit>();
                            //           final vid = video.id.toString();

                            //           if (await cubit.isVideoCachedById(vid)) {
                            //             AppMessage.showFlushbar(
                            //               context: context,
                            //               title: "Info",
                            //               message: 'Video already downloaded',
                            //               backgroundColor:
                            //                   AppColors.messageInfo,
                            //               iconData: Icons.check_circle,
                            //               iconColor: AppColors.iconWhite,
                            //               isShowProgress: true,
                            //               duration: const Duration(seconds: 4),
                            //             );
                            //             return;
                            //           }

                            //           cubit.downloadVideo(
                            //             videoId: vid,
                            //             fileName:
                            //                 "${video.title.replaceAll(' ', '_')}.mp4",
                            //           );
                            //         }
                            //       },
                            //     );
                            //   },
                            // ),
                            IconButton(
                              icon: const Icon(
                                Icons.messenger_outline,
                                color: Colors.white,
                              ),
                              onPressed: () => openCommentsSheet(
                                context,
                                widget.videoId ?? 0,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              onPressed: openSettingsSheet,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(child: AppLoading.circular()),
      ),
    );
  }
}
