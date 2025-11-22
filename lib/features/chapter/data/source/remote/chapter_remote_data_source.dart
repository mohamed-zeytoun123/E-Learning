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
import 'package:e_learning/features/chapter/data/models/video_model/video_pagination_model.dart';

abstract class ChapterRemoteDataSource {
  //?--------------------------------------------------------

  //* Get Chapter by ID
  Future<Either<Failure, ChapterDetailsModel>> getChapterByIdRemote({
    required String courseSlug,
    required int chapterId,
  });

  //* Get Chapter Attachments
  Future<Either<Failure, List<AttachmentModel>>> getChapterAttachmentsRemote({
    required int chapterId,
  });

  //?---  Quize  -----------------------------------------------------

  //* Step 1 :  Get Quiz Details by Chapter ID
  Future<Either<Failure, QuizDetailsModel>> getQuizDetailsByChapterRemote({
    required int chapterId,
  });

  //* Step 2 : Start Quiz
  Future<Either<Failure, StartQuizModel>> startQuizRemote({
    required int quizId,
  });

  //* Step 3 : Submit Quiz Answer
  Future<Either<Failure, AnswerModel>> submitQuizAnswerRemote({
    required int quizId,
    required int questionId,
    required int selectedChoiceId,
  });

  //* Step 4 : Submit Completed Quiz (Final submit + grading)
  Future<Either<Failure, SubmitCompletedModel>> submitCompletedQuizRemote({
    required int attemptId,
  });

  //?--------------------------------------------------------

  //* Get Videos by Chapter ID (with pagination)
  Future<Either<Failure, VideoPaginationModel>> getVideosByChapterRemote({
    required int chapterId,
    int page = 1,
  });

  //* Get Secure Video Streaming URL
  Future<Either<Failure, VideoStreamModel>> getSecureVideoUrlRemote({
    required String videoId,
  });

  //* Download Video File (Bytes)
  Future<Either<Failure, Uint8List>> downloadVideoRemote({
    required String videoId,
  });

  //* Download Video File (Bytes) with Progress Callback
  Future<Either<Failure, Uint8List>> downloadVideoRemoteWithProgress({
    required String videoId,
    Function(double progress)? onProgress,
  });

  //?--------------------------------------------------------
}
