import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Video/presentation/widgets/bootom_sheet_settings_widget.dart';
import 'package:e_learning/features/Video/presentation/widgets/bottom_sheet_comments_widget.dart';

class VideoPlayingPage extends StatefulWidget {
  final void Function(Duration)? onPositionChanged;
  const VideoPlayingPage({super.key, this.onPositionChanged});

  @override
  State<VideoPlayingPage> createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;
  double _currentSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _videoController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );

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
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  void _openCommentsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: SizedBox(
            height: 605.h,
            child: const BottomSheetCommentsWidget(),
          ),
        );
      },
    );
  }

  void _openSettingsSheet() {
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
              _videoController.setPlaybackSpeed(newSpeed);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _videoController.value.isInitialized
          ? Stack(
              children: [
                Center(child: Chewie(controller: _chewieController)),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      color: Colors.black.withOpacity(0.3),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                            onPressed: () {
                              if (_chewieController.isFullScreen) {
                                _chewieController.exitFullScreen();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Video Full Title", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                              Text("Course Name", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          IconButton(icon: const Icon(Icons.messenger_outline, color: Colors.white), onPressed: _openCommentsSheet),
                          IconButton(icon: const Icon(Icons.download, color: Colors.white), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.settings, color: Colors.white), onPressed: _openSettingsSheet),
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
