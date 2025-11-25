import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/features/Video/data/models/video_stream_model.dart';

abstract class VideoRepository {
  //?---------------------------------------------------------------

  //* Get Secure Video Streaming URL
  Future<Either<Failure, VideoStreamModel>> getSecureVideoUrlRepo({
    required String videoId,
  });

  //?---------------------------------------------------------------
}
