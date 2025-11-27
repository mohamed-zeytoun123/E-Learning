import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:network/failures/failures.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';
import 'package:e_learning/features/Video/data/source/remote/video_remote_data_source.dart';

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final API api;

  VideoRemoteDataSourceImpl({required this.api});

  //?---------------------------------------------------------------
  //* Get Secure Video Streaming URL
  @override
  Future<Either<Failure, VideoStreamModel>> getSecureVideoUrlRemote({
    required String videoId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getSecureVideoUrl(videoId),
      );

      final ApiResponse response = await api.get(request);

      log("SECURE VIDEO RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> &&
            data.containsKey("secure_streaming_url")) {
          // استخدام الموديل بدل String مباشر
          final video = VideoStreamModel.fromJson(data);
          return Right(video);
        } else {
          return Left(FailureServer());
        }
      } else {
        return Left(
          Failure(
            message: response.body?['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?---------------------------------------------------------------
}
