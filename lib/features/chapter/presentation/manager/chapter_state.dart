import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/start_quiz_model.dart';

class ChapterState {
  //?--------------------------------------------------------
  //* Get Chapter Details
  final ChapterDetailsModel? chapter;
  final ResponseStatusEnum chaptersStatus;
  final String? chaptersError;

  //* Get Chapter Attachments
  final List<AttachmentModel>? attachments;
  final ResponseStatusEnum attachmentsStatus;
  final String? attachmentsError;

  //*---  Quize  ---------------------------
  //* Step 1 : Get Quiz Details by Chapter ID
  final QuizDetailsModel? quizDetails;
  final ResponseStatusEnum quizDetailsStatus;
  final String? quizDetailsError;

  //* Step 2 : Start Quiz
  final StartQuizModel? statrtQuiz;
  final ResponseStatusEnum statrtQuizStatus;
  final String? statrtQuizError;

  //* Step 3 : Submit Quiz Answer
  final AnswerModel? answer;
  final ResponseStatusEnum answerStatus;
  final String? answerError;

  //?----------------------------------------------------------
  ChapterState({
    //* Get Chapter Details
    this.chapter,
    this.chaptersStatus = ResponseStatusEnum.initial,
    this.chaptersError,

    //* Get Chapter Attachments
    this.attachments,
    this.attachmentsStatus = ResponseStatusEnum.initial,
    this.attachmentsError,

    //*---  Quize  ---------------------------
    //* Step 1  : Get Quiz Details by Chapter ID
    this.quizDetails,
    this.quizDetailsStatus = ResponseStatusEnum.initial,
    this.quizDetailsError,

    //* Step 2 : Start Quiz
    this.statrtQuiz,
    this.statrtQuizStatus = ResponseStatusEnum.initial,
    this.statrtQuizError,

    //* Step 3 : Submit Quiz Answer
    this.answer,
    this.answerStatus = ResponseStatusEnum.initial,
    this.answerError,
  });

  //?--------------------------------------------------------
  ChapterState copyWith({
    //* Get Chapter Details
    ChapterDetailsModel? chapter,
    ResponseStatusEnum? chaptersStatus,
    String? chaptersError,

    //* Get Chapter Attachments
    List<AttachmentModel>? attachments,
    ResponseStatusEnum? attachmentsStatus,
    String? attachmentsError,

    //*---  Quize  ---------------------------
    //* Step 1  : Get Quiz Details by Chapter ID
    QuizDetailsModel? quizDetails,
    ResponseStatusEnum? quizDetailsStatus,
    String? quizDetailsError,

    //* Step 2 : Start Quiz
    StartQuizModel? statrtQuiz,
    ResponseStatusEnum? statrtQuizStatus,
    String? statrtQuizError,

    //* Step 3 : Submit Quiz Answer
    AnswerModel? answer,
    ResponseStatusEnum? answerStatus,
    String? answerError,
  }) {
    return ChapterState(
      //* Get Chapter Details
      chapter: chapter ?? this.chapter,
      chaptersStatus: chaptersStatus ?? this.chaptersStatus,
      chaptersError: chaptersError,

      //* Get Chapter Attachments
      attachments: attachments ?? this.attachments,
      attachmentsStatus: attachmentsStatus ?? this.attachmentsStatus,
      attachmentsError: attachmentsError,

      //*---  Quize  ---------------------------
      //* Step 1  : Get Quiz Details by Chapter ID
      quizDetails: quizDetails ?? this.quizDetails,
      quizDetailsStatus: quizDetailsStatus ?? this.quizDetailsStatus,
      quizDetailsError: quizDetailsError,

      //* Step 2 : Start Quiz
      statrtQuiz: statrtQuiz ?? this.statrtQuiz,
      statrtQuizStatus: statrtQuizStatus ?? this.statrtQuizStatus,
      statrtQuizError: statrtQuizError,

      //* Step 3 : Submit Quiz Answer
      answer: answer ?? this.answer,
      answerStatus: answerStatus ?? this.answerStatus,
      answerError: answerError,
    );
  }
}
