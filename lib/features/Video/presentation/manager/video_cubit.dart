import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/Video/data/source/repo/video_repository.dart';
import 'package:e_learning/features/Video/presentation/manager/video_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoRepository repo;

  VideoCubit({required this.repo}) : super(VideoState());

  //?---------------------------------------------------------------
  //* Get Secure Video Streaming
  Future<void> getSecureVideo({required String videoId}) async {
    emit(
      state.copyWith(
        videoStreamingStatus: ResponseStatusEnum.loading,
        videoStreamingError: null,
      ),
    );

    final result = await repo.getSecureVideoUrlRepo(videoId: videoId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            videoStreamingStatus: ResponseStatusEnum.failure,
            videoStreamingError: failure.message,
          ),
        );
      },
      (videoModel) {
        emit(
          state.copyWith(
            videoStreamingStatus: ResponseStatusEnum.success,
            videoStreaming: videoModel,
          ),
        );
      },
    );
  }

  //?---------------------------------------------------------------
}
