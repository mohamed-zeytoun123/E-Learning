import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/start_quiz_model.dart';

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
  //?--------------------------------------------------------
}
