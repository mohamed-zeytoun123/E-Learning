import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:network/failures/failures.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/start_quiz_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/submit/submit_completed_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comment_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comments_result_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/videos_result_model.dart';
import 'package:e_learning/features/chapter/data/source/local/chapter_local_data_source.dart';
import 'package:e_learning/features/chapter/data/source/remote/chapter_remote_data_source.dart';
import 'package:e_learning/features/chapter/data/source/repo/chapter_repository.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';

class ChapterRepositoryImpl implements ChapterRepository {
  final ChapterRemoteDataSource remote;
  final ChapterLocalDataSource local;
  final NetworkInfoService network;

  ChapterRepositoryImpl({
    required this.remote,
    required this.local,
    required this.network,
  });
  //?--------------------------------------------------------
  //* Get Chapter by ID
  @override
  Future<Either<Failure, ChapterDetailsModel>> getChapterByIdRepo({
    required String courseSlug,
    required int chapterId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getChapterByIdRemote(
        courseSlug: courseSlug,
        chapterId: chapterId,
      );

      return result.fold(
        (failure) => Left(failure),
        (chapter) => Right(chapter),
      );
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?--------------------------------------------------------
  //* Get Chapter Attachments
  @override
  Future<Either<Failure, List<AttachmentModel>>> getChapterAttachmentsRepo({
    required int chapterId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getChapterAttachmentsRemote(
        chapterId: chapterId,
      );

      return result.fold(
        (failure) => Left(failure),
        (attachments) => Right(attachments),
      );
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?--- Quiz -----------------------------------------------------
  //* Step 1 : Get Quiz Details by Chapter ID
  @override
  Future<Either<Failure, QuizDetailsModel>> getQuizDetailsByChapterRepo({
    required int chapterId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getQuizDetailsByChapterRemote(
        chapterId: chapterId,
      );

      return result.fold((failure) => Left(failure), (quiz) => Right(quiz));
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?-------------------
  //* Step 2 : Start Quiz
  @override
  Future<Either<Failure, StartQuizModel>> startQuizRepo({
    required int quizId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.startQuizRemote(quizId: quizId);

      return result.fold((failure) => Left(failure), (quiz) => Right(quiz));
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?-----------
  //* Step 3 : Submit Quiz Answer
  @override
  Future<Either<Failure, AnswerModel>> submitQuizAnswerRepo({
    required int quizId,
    required int questionId,
    required int selectedChoiceId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.submitQuizAnswerRemote(
        quizId: quizId,
        questionId: questionId,
        selectedChoiceId: selectedChoiceId,
      );

      return result.fold((failure) => Left(failure), (answer) => Right(answer));
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?--------------------------------------------------------

  //* Update Video Progress (Cubit)
  @override
  void updateVideoProgress({
    required int videoId,
    required int watchedSeconds,
  }) {
    remote.updateVideoProgressRemote(
      videoId: videoId,
      watchedSeconds: watchedSeconds,
    );
  }

  //?--------------------------------------------------------

  //* Repository method
  @override
  Future<Either<Failure, VideosResultModel>> getVideosRepo({
    required int chapterId,
    int? page,
  }) async {
    if (!await network.isConnected) {
      return Left(FailureNoConnection());
    }

    final result = await remote.getVideosByChapterRemote(
      chapterId: chapterId,
      page: page ?? 1,
    );

    return result.fold((failure) => Left(failure), (paginatedVideos) {
      final videos = paginatedVideos.results;

      if (videos.isEmpty) {
        return Left(FailureNoData());
      }

      return Right(
        VideosResultModel(
          videos: videos,
          hasNextPage: paginatedVideos.currentPage < paginatedVideos.totalPages,
        ),
      );
    });
  }
  //?--------------------------------------------------------

  //* Get Secure Video Streaming URL (Return Model)
  @override
  Future<Either<Failure, VideoStreamModel>> getSecureVideoUrlRepo({
    required String videoId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getSecureVideoUrlRemote(videoId: videoId);

      return result.fold(
        (failure) => Left(failure),
        (videoModel) => Right(videoModel),
      );
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?--------------------------------------------------------
  //* Download + Cache + Return Encrypted Video with Progress
  @override
  Future<Either<Failure, List<int>>> getEncryptedVideoRepo({
    required String videoId,
    Function(double progress)? onProgress,
  }) async {
    try {
      // 1) إذا الفيديو موجود بالكاش → رجّعو من التخزين
      if (await local.isVideoCached(videoId)) {
        final cachedBytes = await local.getEncryptedVideo(videoId);
        return Right(cachedBytes);
      }

      // 2) إذا غير موجود بالكاش لكن في إنترنت → نزلو من الريموت
      if (await network.isConnected) {
        final downloadResult = await remote.downloadVideoRemoteWithProgress(
          videoId: videoId,
          onProgress: onProgress,
        );

        return downloadResult.fold((failure) => Left(failure), (
          downloadedBytes,
        ) async {
          final encryptedForCache = _encryptForCache(downloadedBytes, videoId);
          await local.cacheEncryptedVideo(
            videoId: videoId,
            encryptedBytes: encryptedForCache,
          );
          return Right(encryptedForCache);
        });
      }

      // 5) لا كاش ولا إنترنت
      return Left(FailureNoConnection());
    } catch (e) {
      return Left(Failure.handleError(e as DioException));
    }
  }

  //?------------------------------------------------------------------
  @override
  Future<Uint8List> downloadVideoBytes(
    String url, {
    Function(double progress)? onProgress,
  }) async {
    final req = http.Request('GET', Uri.parse(url));
    final response = await req.send();

    final contentLength = response.contentLength ?? 0;
    final bytes = <int>[];
    int received = 0;

    await for (final chunk in response.stream) {
      bytes.addAll(chunk);
      received += chunk.length;
      if (onProgress != null && contentLength != 0) {
        onProgress(received / contentLength);
      }
    }

    return Uint8List.fromList(bytes);
  }

  //?--------------------------------------------------------
  //* Check if device is connected to the internet
  @override
  Future<bool> get isConnected async {
    return await network.isConnected;
  }

  //?--------------------------------------------------------

  Uint8List _encryptForCache(Uint8List plainBytes, String videoId) {
    final key = _getKeyFromVideoId(videoId);
    final iv = Uint8List(16);
    final cipher =
        PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
          ..init(
            true,
            pc.PaddedBlockCipherParameters(
              pc.ParametersWithIV(pc.KeyParameter(key), iv),
              null,
            ),
          );
    return cipher.process(plainBytes);
  }

  Uint8List _getKeyFromVideoId(String videoId) {
    final padded = videoId.padRight(16, '0');
    final keyStr = padded.substring(0, 16);
    return Uint8List.fromList(keyStr.codeUnits);
  }

  //?--------------------------------------------------------
  //* Get Comments Repository
  @override
  Future<Either<Failure, CommentsResultModel>> getCommentsRepo({
    required int videoId,
    int page = 1,
  }) async {
    if (!await network.isConnected) {
      return Left(FailureNoConnection());
    }

    final result = await remote.getCommentsRemote(
      chapterId: videoId,
      page: page,
    );

    return result.fold(
      (failure) => Left(failure),
      (commentsResult) => Right(commentsResult),
    );
  }

  //?--------------------------------------------------------
  //* Add Comment Repository
  @override
  Future<Either<Failure, CommentModel>> addVideoCommentRepo({
    required String videoId,
    required String content,
  }) async {
    if (!await network.isConnected) {
      return Left(FailureNoConnection());
    }

    final result = await remote.addVideoCommentRemote(
      videoId: videoId,
      content: content,
    );

    return result.fold((failure) => Left(failure), (comment) => Right(comment));
  }

  //?--------------------------------------------------------
  //* Submit quiz with all answers
  @override
  Future<Either<Failure, SubmitCompletedModel>> submitQuizAnswersListRepo({
    required int attemptId,
    required List<Map<String, dynamic>> answers,
  }) async {
    if (await network.isConnected) {
      final result = await remote.submitQuizFinalRemote(
        attemptId: attemptId,
        answers: answers,
      );

      return result.fold((failure) => Left(failure), (submit) => Right(submit));
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?--------------------------------------------------------
}
