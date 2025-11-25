import 'dart:typed_data';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:netwoek/network.dart';
import 'package:netwoek/network/api/api_request.dart';
import 'package:netwoek/network/api/api_response.dart';
import 'package:e_learning/features/Video/data/models/video_stream_model.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/start_quiz_model.dart';
import 'package:e_learning/features/chapter/data/models/submit_completed_model.dart';
import 'package:e_learning/core/model/paginated_model.dart';
import 'package:e_learning/features/chapter/data/models/video_model.dart';
import 'package:e_learning/features/chapter/data/source/remote/chapter_remote_data_source.dart';
import 'package:path_provider/path_provider.dart';

class ChapterRemoteDataSourceImpl implements ChapterRemoteDataSource {
  final API api;

  ChapterRemoteDataSourceImpl({required this.api});

  //?----------------------------------------------------
  //* Get Chapter by ID
  @override
  Future<Either<Failure, ChapterDetailsModel>> getChapterByIdRemote({
    required String courseSlug,
    required int chapterId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getChapterById(courseSlug, chapterId.toString()),
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final chapter = ChapterDetailsModel.fromMap(data);
          return Right(chapter);
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

  //?----------------------------------------------------
  //* Get Chapter Attachments
  @override
  Future<Either<Failure, List<AttachmentModel>>> getChapterAttachmentsRemote({
    required int chapterId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getChapterAttachments(chapterId),
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List<dynamic>) {
          final attachments = (data as List<dynamic>)
              .map((e) => AttachmentModel.fromMap(e as Map<String, dynamic>))
              .toList();

          return Right(attachments);
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

  //?----------------------------------------------------
  //* Get Quiz Details by Chapter ID
  @override
  Future<Either<Failure, QuizDetailsModel>> getQuizDetailsByChapterRemote({
    required int chapterId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getQuizByChapter("$chapterId"),
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data.containsKey("error")) {
          return Left(
            Failure(message: data["error"].toString(), errorCode: 404),
          );
        }

        if (data is Map<String, dynamic>) {
          final quiz = QuizDetailsModel.fromJson(data);
          return Right(quiz);
        }

        return Left(Failure(message: 'Server error'));
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

  //?----------------------------------------------------
  //* Start Quiz
  @override
  Future<Either<Failure, StartQuizModel>> startQuizRemote({
    required int quizId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.startQuiz(quizId),
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.post(request);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final quiz = StartQuizModel.fromJson(data);
          return Right(quiz);
        } else {
          return Left(Failure(message: 'Server error'));
        }
      } else {
        final body = response.body;
        final errorMessage = (body is Map && body['error'] != null)
            ? body['error'].toString()
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

  //?----------------------------------------------------
  //* Submit Quiz Answer
  @override
  Future<Either<Failure, AnswerModel>> submitQuizAnswerRemote({
    required int quizId,
    required int questionId,
    required int selectedChoiceId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.submitQuizAnswer(quizId),
        body: {
          "question_id": questionId,
          "selected_choice_id": selectedChoiceId,
        },
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.post(request);

      final data = response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is Map<String, dynamic>) {
          if (data.containsKey("error")) {
            return Left(
              Failure(
                message: data["error"].toString(),
                errorCode: response.statusCode,
              ),
            );
          } else {
            final answer = AnswerModel.fromJson(data);
            return Right(answer);
          }
        } else {
          return Left(Failure(message: 'Server error'));
        }
      } else {
        if (data is Map<String, dynamic> && data.containsKey("error")) {
          return Left(
            Failure(
              message: data["error"].toString(),
              errorCode: response.statusCode,
            ),
          );
        }
        return Left(
          Failure(message: "Unknown error", errorCode: response.statusCode),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
  //* Submit Completed Quiz
  @override
  Future<Either<Failure, SubmitCompletedModel>> submitCompletedQuizRemote({
    required int attemptId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.submitCompletedQuiz(attemptId),
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.post(request);

      final data = response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is Map<String, dynamic>) {
          if (data.containsKey("error")) {
            return Left(
              Failure(
                message: data["error"].toString(),
                errorCode: response.statusCode,
              ),
            );
          }

          final submit = SubmitCompletedModel.fromJson(data);
          return Right(submit);
        } else {
          return Left(Failure(message: 'Server error'));
        }
      }

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        return Left(
          Failure(
            message: data["error"].toString(),
            errorCode: response.statusCode,
          ),
        );
      }

      return Left(
        Failure(message: "Unknown error", errorCode: response.statusCode),
      );
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
  //* Get Videos by Chapter ID (pagination)
  @override
  Future<Either<Failure, PaginationModel<VideoModel>>> getVideosByChapterRemote({
    required int chapterId,
    int page = 1,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getVideos(chapterId: chapterId, page: page),
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data['results'] is List) {
          final paginatedVideos = PaginationModel<VideoModel>.fromJson(data, (json) => VideoModel.fromJson(json as Map<String, dynamic>));
          return Right(paginatedVideos);
        } else {
          return Left(Failure(message: 'Invalid data format from server'));
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

  //?----------------------------------------------------
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

  //?----------------------------------------------------
  //* Download Video File (Bytes)
  @override
  Future<Either<Failure, Uint8List>> downloadVideoRemote({
    required String videoId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.downloadVideo(videoId),
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Uint8List) {
          return Right(data as Uint8List);
        }

        if (data is List<int>) {
          return Right(Uint8List.fromList(data as List<int>));
        }

        if (data is List) {
          final intList = (data as List).cast<int>();
          return Right(Uint8List.fromList(intList));
        }

        return Left(Failure(message: "Invalid video data format"));
      } else {
        return Left(
          Failure(message: "Download error", errorCode: response.statusCode),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //* Download Video File (Bytes) with Progress Callback
  @override
  Future<Either<Failure, Uint8List>> downloadVideoRemoteWithProgress({
    required String videoId,
    Function(double progress)? onProgress,
  }) async {
    try {
      final url = AppUrls.downloadVideo(videoId);
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_video_$videoId.mp4');

      // Use Dio's download method with progress callback
      final response = await api.dio.download(
        url,
        tempFile.path,
        onReceiveProgress: (received, total) {
          if (onProgress != null && total > 0) {
            onProgress(received / total);
          }
        },
      );

      if (response.statusCode == 200) {
        // Read the downloaded file as bytes
        final bytes = await tempFile.readAsBytes();
        // Delete the temporary file
        await tempFile.delete();
        return Right(bytes);
      } else {
        // Delete the temporary file if download failed
        if (await tempFile.exists()) {
          await tempFile.delete();
        }
        return Left(
          Failure(
              message: "Download error", errorCode: response.statusCode ?? 500),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?--------------------------------------------------------
}
