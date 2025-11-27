import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';

abstract class VideoRemoteDataSource {
  //?---------------------------------------------------------------

  //* Get Secure Video Streaming URL
  Future<Either<Failure, VideoStreamModel>> getSecureVideoUrlRemote({
    required String videoId,
  });

  //?---------------------------------------------------------------
}
