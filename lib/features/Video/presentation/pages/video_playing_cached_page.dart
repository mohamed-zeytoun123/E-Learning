import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Video/presentation/widgets/bottom_sheet_speed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';

class VideoPlayingCachedPage extends StatefulWidget {
  final File videoFile;

  const VideoPlayingCachedPage({super.key, required this.videoFile});

  @override
  State<VideoPlayingCachedPage> createState() => _VideoPlayingCachedPageState();
}

class _VideoPlayingCachedPageState extends State<VideoPlayingCachedPage> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  double _currentSpeed = 1.0;
  bool _videoError = false;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _videoController = VideoPlayerController.file(
        widget.videoFile,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false),
      );

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

      await _videoController.initialize();
      setState(() {
        _isInitializing = false;
      });

      _videoController.addListener(() => setState(() {}));
    } catch (e) {
      debugPrint("Video init failed: $e");
      setState(() {
        _videoError = true;
        _isInitializing = false;
      });
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

  void openSpeedSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => BottomSheetSpeedWidget(
        initialSpeed: _currentSpeed,
        onSpeedSelected: (speed) {
          setState(() {
            _currentSpeed = speed;
            _videoController.setPlaybackSpeed(speed);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isInitializing
          ? Center(child: AppLoading.circular())
          : _videoError
          ? Center(
              child: Text(
                "Cannot play this video",
                style: AppTextStyles.s16w400.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            )
          : Stack(
              children: [
                Center(child: Chewie(controller: _chewieController)),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
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
                            child: Text(
                              widget.videoFile.path.split('/').last,
                              style: AppTextStyles.s16w600.copyWith(
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.speed, color: Colors.white),
                            onPressed: openSpeedSheet,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
