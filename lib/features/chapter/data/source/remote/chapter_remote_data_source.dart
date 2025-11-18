import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/start_quiz_model.dart';

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

  //?--------------------------------------------------------
}
