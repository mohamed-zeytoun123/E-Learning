import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';

abstract class VideoRepository {
  //?---------------------------------------------------------------

  //* Get Secure Video Streaming URL
  Future<Either<Failure, VideoStreamModel>> getSecureVideoUrlRepo({
    required String videoId,
  });

  //?---------------------------------------------------------------
}
