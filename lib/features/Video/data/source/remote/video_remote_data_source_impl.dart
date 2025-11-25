import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:netwoek/network.dart';
import 'package:netwoek/network/api/api_request.dart';
import 'package:netwoek/network/api/api_response.dart';
import 'package:e_learning/features/Video/data/models/video_stream_model.dart';
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
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> &&
            data.containsKey("secure_streaming_url")) {
          // استخدام الموديل بدل String مباشر
          final video = VideoStreamModel.fromJson(data);
          return Right(video);
        } else {
          return Left(Failure(message: 'Server error'));
        }
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['message'] != null)
            ? body['message'].toString()
            : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?---------------------------------------------------------------
}
