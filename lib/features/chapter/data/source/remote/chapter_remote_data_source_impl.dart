import 'dart:developer';
import 'dart:typed_data';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/start_quiz_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/submit/submit_completed_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comment_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comments_result_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/video_pagination_model.dart';
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
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final chapter = ChapterDetailsModel.fromMap(data);
          return Right(chapter);
        } else {
          return Left(FailureServer());
        }
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      } else {
        return Left(Failure(message: exception.toString()));
      }
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
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List) {
          final attachments = data
              .map((e) => AttachmentModel.fromMap(e as Map<String, dynamic>))
              .toList();

          return Right(attachments);
        } else {
          return Left(FailureServer());
        }
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      } else {
        return Left(Failure(message: exception.toString()));
      }
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
      );

      final ApiResponse response = await api.get(request);

      log("QUIZ RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data.containsKey("error")) {
          return Left(
            Failure(message: data["error"].toString(), statusCode: 404),
          );
        }

        if (data is Map<String, dynamic>) {
          final quiz = QuizDetailsModel.fromJson(data);
          return Right(quiz);
        }

        return Left(FailureServer());
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      } else {
        return Left(Failure(message: exception.toString()));
      }
    }
  }

  //?----------------------------------------------------
  //* Start Quiz
  @override
  Future<Either<Failure, StartQuizModel>> startQuizRemote({
    required int quizId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.startQuiz(quizId));

      final ApiResponse response = await api.post(request);

      log("START QUIZ RESPONSE: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final quiz = StartQuizModel.fromJson(data);
          return Right(quiz);
        } else {
          return Left(FailureServer());
        }
      } else {
        return Left(
          Failure(
            message: response.body['error']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      } else {
        return Left(Failure(message: exception.toString()));
      }
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
      );

      final ApiResponse response = await api.post(request);

      log("SUBMIT QUIZ ANSWER RESPONSE: ${response.body}");

      final data = response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is Map<String, dynamic>) {
          if (data.containsKey("error")) {
            return Left(
              Failure(
                message: data["error"].toString(),
                statusCode: response.statusCode,
              ),
            );
          } else {
            final answer = AnswerModel.fromJson(data);
            return Right(answer);
          }
        } else {
          return Left(FailureServer());
        }
      } else {
        if (data is Map<String, dynamic> && data.containsKey("error")) {
          return Left(
            Failure(
              message: data["error"].toString(),
              statusCode: response.statusCode,
            ),
          );
        }
        return Left(
          Failure(message: "Unknown error", statusCode: response.statusCode),
        );
      }
    } catch (exception) {
      log(exception.toString());
      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      } else {
        return Left(Failure(message: exception.toString()));
      }
    }
  }



  //?----------------------------------------------------
  //* Get Videos by Chapter ID (pagination)
  @override
  Future<Either<Failure, VideoPaginationModel>> getVideosByChapterRemote({
    required int chapterId,
    int page = 1,
  }) async {
    try {
      log('Fetching videos for chapterId=$chapterId, page=$page');

      final ApiRequest request = ApiRequest(
        url: AppUrls.getVideos(chapterId: chapterId, page: page),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data['results'] is List) {
          final paginatedVideos = VideoPaginationModel.fromMap(data);
          return Right(paginatedVideos);
        } else {
          return Left(Failure(message: 'Invalid data format from server'));
        }
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      } else {
        return Left(Failure(message: exception.toString()));
      }
    }
  }

  //?----------------------------------------------------
  //* Update Video Progress
  @override
  Future<void> updateVideoProgressRemote({
    required int videoId,
    required int watchedSeconds,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.updateVideoProgress(videoId),
        body: {"watched_seconds": watchedSeconds.toString()},
      );

      final ApiResponse response = await api.post(request);

      log("UPDATE VIDEO PROGRESS RESPONSE: ${response.body}");

      // حتى لو حصل خطأ في الـ status code، مجرد تسجيله ولا ترجع شيء
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        final data = response.body;
        log(
          "Error updating video progress: ${data['message'] ?? "Unknown error"}",
        );
      }
    } catch (exception) {
      log("Exception updating video progress: $exception");
      // أي خطأ في Dio أو آخر، نسجله فقط
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
      );

      final ApiResponse response = await api.get(request);

      log("SECURE VIDEO RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> &&
            data.containsKey("secure_streaming_url")) {
          final video = VideoStreamModel.fromJson(data);
          return Right(video);
        } else {
          return Left(FailureServer());
        }
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      } else {
        return Left(Failure(message: exception.toString()));
      }
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
        // مهم: لأنو الفيديو بيرجع binary
        responseType: ResponseType.bytes,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Uint8List) {
          return Right(data);
        }

        if (data is List<int>) {
          return Right(Uint8List.fromList(data));
        }

        return Left(Failure(message: "Invalid video data format"));
      } else {
        // Extract error message from response if available
        String errorMessage = "Download error";
        if (response.body is Map<String, dynamic>) {
          final data = response.body as Map<String, dynamic>;
          if (data.containsKey('detail')) {
            errorMessage = data['detail'].toString();
          } else if (data.containsKey('message')) {
            errorMessage = data['message'].toString();
          } else if (data.containsKey('error')) {
            errorMessage = data['error'].toString();
          }
        }
        
        return Left(
          Failure(message: errorMessage, statusCode: response.statusCode),
        );
      }
    } catch (exception) {
      log(exception.toString());

      if (exception is DioException) {
        return Left(Failure.handleError(exception));
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
      final response = await (api.dio as Dio).download(
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
        
        // Extract error message from response if available
        String errorMessage = "Download error";
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;
          if (data.containsKey('detail')) {
            errorMessage = data['detail'].toString();
          } else if (data.containsKey('message')) {
            errorMessage = data['message'].toString();
          } else if (data.containsKey('error')) {
            errorMessage = data['error'].toString();
          }
        }
        
        return Left(
          Failure(
            message: errorMessage,
            statusCode: response.statusCode ?? 500,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());

      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      }

      return Left(Failure(message: exception.toString()));
    }
  }
  //?--------------------------------------------------------

  //* Get Comments for a Video (Pagenations)
  @override
  Future<Either<Failure, CommentsResultModel>> getCommentsRemote({
    required int chapterId,
    int page = 1,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getVideoComments(chapterId, page: page),
      );

      final ApiResponse response = await api.get(request);

      log('COMMENTS RESPONSE page $page: ${response.body}');

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data['results'] is List) {
          final commentsList = (data['results'] as List)
              .map((e) => CommentModel.fromMap(e as Map<String, dynamic>))
              .toList();

          final hasNext = data['next'] != null;

          return Right(
            CommentsResultModel(comments: commentsList, hasNextPage: hasNext),
          );
        } else {
          return Right(CommentsResultModel.empty());
        }
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log('getCommentsRemote error: $exception');

      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      }

      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
  //* Add Comment to Video
  @override
  Future<Either<Failure, CommentModel>> addVideoCommentRemote({
    required String videoId,
    required String content,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.addVideoComment(videoId),
        body: {"content": content},
      );

      final ApiResponse response = await api.post(request);

      log("ADD COMMENT RESPONSE: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final comment = CommentModel.fromMap(data);
          return Right(comment);
        } else {
          return Left(FailureServer());
        }
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log("addVideoCommentRemote exception: $exception");

      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      }

      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
  //?----------------------------------------------------
  //* Submit quiz with all answers
  @override
  Future<Either<Failure, SubmitCompletedModel>> submitQuizFinalRemote({
    required int attemptId,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.submitCompletedQuiz(attemptId),
        body: {"answers": answers},
      );

      final ApiResponse response = await api.post(request);

      log("FINAL SUBMIT QUIZ RESPONSE: ${response.body}");

      final data = response.body;

      // SUCCESS
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is Map<String, dynamic>) {
          if (data.containsKey("error")) {
            return Left(
              Failure(
                message: data["error"].toString(),
                statusCode: response.statusCode,
              ),
            );
          }

          final submit = SubmitCompletedModel.fromJson(data);
          return Right(submit);
        } else {
          return Left(FailureServer());
        }
      }

      // ERROR
      if (data is Map<String, dynamic> && data.containsKey("error")) {
        return Left(
          Failure(
            message: data["error"].toString(),
            statusCode: response.statusCode,
          ),
        );
      }

      return Left(
        Failure(message: "Unknown error", statusCode: response.statusCode),
      );
    } catch (exception) {
      log(exception.toString());
      if (exception is DioException) {
        return Left(Failure.handleError(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?--------------------------------------------------------
}
