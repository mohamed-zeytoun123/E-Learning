import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/start_quiz_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/submit/submit_completed_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comment_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comments_result_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/video_progress_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/videos_result_model.dart';

abstract class ChapterRepository {
  //?--------------------------------------------------------

  //* Get Chapter by ID
  Future<Either<Failure, ChapterDetailsModel>> getChapterByIdRepo({
    required String courseSlug,
    required int chapterId,
  });

  //* Get Chapter Attachments
  Future<Either<Failure, List<AttachmentModel>>> getChapterAttachmentsRepo({
    required int chapterId,
  });

  //?-----  Quiz ---------------------------------------------------

  //* Step 1 : Get Quiz Details by Chapter ID
  Future<Either<Failure, QuizDetailsModel>> getQuizDetailsByChapterRepo({
    required int chapterId,
  });

  //* Step 2 : Start Quiz
  Future<Either<Failure, StartQuizModel>> startQuizRepo({required int quizId});

  //* Step 3 : Submit Quiz Answer
  Future<Either<Failure, AnswerModel>> submitQuizAnswerRepo({
    required int quizId,
    required int questionId,
    required int selectedChoiceId,
  });

  //* Step 4 : Submit Completed Quiz (Final submit + grading)
  Future<Either<Failure, SubmitCompletedModel>> submitCompletedQuizRepo({
    required int attemptId,
  });
  //?--------------------------------------------------------
  //* Get Videos by Chapter with Pagination (Repository)
  Future<Either<Failure, VideosResultModel>> getVideosRepo({
    required int chapterId,
    int? page,
  });

  //* Get Secure Video Streaming URL (Return Model)
  Future<Either<Failure, VideoStreamModel>> getSecureVideoUrlRepo({
    required String videoId,
  });

  //* Download + Cache + Return Encrypted Video
  Future<Either<Failure, List<int>>> getEncryptedVideoRepo({
    required String videoId,
    Function(double progress)? onProgress,
  });

  Future<Uint8List> downloadVideoBytes(
    String url, {
    Function(double progress)? onProgress,
  });

  //* Check if device is connected to the internet
  Future<bool> get isConnected;

  //* Update Video Progress (Repository)
  void updateVideoProgress({required int videoId, required int watchedSeconds});

  //* Get Comments Repository
  Future<Either<Failure, CommentsResultModel>> getCommentsRepo({
    required int videoId,
    int page = 1,
  });

  //* Add Comment Repository
  Future<Either<Failure, CommentModel>> addVideoCommentRepo({
    required String videoId,
    required String content,
  });
  //?--------------------------------------------------------
}
