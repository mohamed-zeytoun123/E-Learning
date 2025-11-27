import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';
import 'package:e_learning/features/Video/data/source/remote/video_remote_data_source.dart';
import 'package:e_learning/features/Video/data/source/repo/video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remote;
  final NetworkInfoService network;

  VideoRepositoryImpl({required this.remote, required this.network});

  //?---------------------------------------------------------------
  //* Get Secure Video Streaming URL (Return Model)
  @override
  Future<Either<Failure, VideoStreamModel>> getSecureVideoUrlRepo({
    required String videoId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getSecureVideoUrlRemote(videoId: videoId);

      return result.fold(
        (failure) => Left(failure),
        (videoModel) => Right(videoModel), // نرجع الموديل كامل
      );
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?---------------------------------------------------------------
}
