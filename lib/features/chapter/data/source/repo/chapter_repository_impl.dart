import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/start_quiz_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/submit/submit_completed_model.dart';
import 'package:e_learning/features/chapter/data/source/remote/chapter_remote_data_source.dart';
import 'package:e_learning/features/chapter/data/source/repo/chapter_repository.dart';

class ChapterRepositoryImpl implements ChapterRepository {
  final ChapterRemoteDataSource remote;
  // final ChapterLocalDataSource local;
  final NetworkInfoService network;

  ChapterRepositoryImpl({
    required this.remote,
    // required this.local,
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

  //?-----------
  //* Step 4 : Submit Completed Quiz (Final submit + grading)
  @override
  Future<Either<Failure, SubmitCompletedModel>> submitCompletedQuizRepo({
    required int attemptId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.submitCompletedQuizRemote(
        attemptId: attemptId,
      );

      return result.fold((failure) => Left(failure), (submit) => Right(submit));
    } else {
      return Left(FailureNoConnection());
    }
  }

  //?--------------------------------------------------------
}
