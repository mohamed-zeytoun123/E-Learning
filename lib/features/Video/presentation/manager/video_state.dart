import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';

class VideoState {
  //* Get Video Streaming
  final VideoStreamModel? videoStreaming;
  final ResponseStatusEnum videoStreamingStatus;
  final String? videoStreamingError;

  //?-----------------------------------------------------
  VideoState({
    //* Get Video Streaming
    this.videoStreaming,
    this.videoStreamingStatus = ResponseStatusEnum.initial,
    this.videoStreamingError,
    //?-----------------------------------------------------
  });

  VideoState copyWith({
    //* Get Video Streaming
    VideoStreamModel? videoStreaming,
    ResponseStatusEnum? videoStreamingStatus,
    String? videoStreamingError,
    //?-----------------------------------------------------
  }) {
    return VideoState(
      //* Get Video Streaming
      videoStreaming: videoStreaming ?? this.videoStreaming,
      videoStreamingStatus: videoStreamingStatus ?? this.videoStreamingStatus,
      videoStreamingError: videoStreamingError ?? this.videoStreamingError,
      //?-----------------------------------------------------
    );
  }
}
