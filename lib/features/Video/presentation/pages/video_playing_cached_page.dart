import 'dart:io';
import 'dart:typed_data';
import 'package:chewie/chewie.dart';
import 'package:e_learning/features/Video/presentation/widgets/bottom_sheet_speed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:pointycastle/api.dart' as pc;

class VideoPlayingCachedPage extends StatefulWidget {
  final String videoId;
  final String fileName;
  final Uint8List encryptedBytes;
  final File? videoFile;

  const VideoPlayingCachedPage({
    super.key,
    required this.videoId,
    required this.fileName,
    required this.encryptedBytes,
    this.videoFile,
  });

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
      File? videoFileToPlay;

      // If we already have a video file, use it directly
      if (widget.videoFile != null) {
        videoFileToPlay = widget.videoFile;
      }
      // If we have encrypted bytes, decrypt them first
      else if (widget.encryptedBytes.isNotEmpty) {
        // 1️⃣ فك التشفير أولاً
        videoFileToPlay = await _decryptAndWriteTempFile(
          widget.encryptedBytes,
          widget.videoId,
          widget.fileName,
        );
      }

      if (videoFileToPlay == null) {
        setState(() {
          _videoError = true;
          _isInitializing = false;
        });
        return;
      }

      // 2️⃣ إنشاء VideoPlayerController
      _videoController = VideoPlayerController.file(
        videoFileToPlay,
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

  Future<File?> _decryptAndWriteTempFile(
    Uint8List encryptedBytes,
    String videoId,
    String fileName,
  ) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final safeFileName = fileName.isNotEmpty
          ? fileName
          : 'video_$videoId.mp4';
      final tempFile = File('${tempDir.path}/$safeFileName');

      final decryptedBytes = _decryptVideoBytes(encryptedBytes, videoId);
      await tempFile.writeAsBytes(decryptedBytes);
      return tempFile;
    } catch (e) {
      debugPrint("Decryption failed: $e");
      return null;
    }
  }

  Uint8List _decryptVideoBytes(Uint8List encryptedBytes, String videoId) {
    final key = _getKeyFromVideoId(videoId);
    final iv = Uint8List(16);

    final cipher =
        PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
          ..init(
            false,
            pc.PaddedBlockCipherParameters(
              pc.ParametersWithIV(pc.KeyParameter(key), iv),
              null,
            ),
          );

    return cipher.process(encryptedBytes);
  }

  Uint8List _getKeyFromVideoId(String videoId) {
    final padded = videoId.padRight(16, '0');
    final keyStr = padded.substring(0, 16);
    return Uint8List.fromList(keyStr.codeUnits);
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
                              widget.fileName,
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
