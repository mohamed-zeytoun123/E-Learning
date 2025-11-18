import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/chapter/data/source/repo/chapter_repository.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit({required this.repo}) : super(ChapterState());
  final ChapterRepository repo;

  //?--------------------------------------------------------
  //* Get Chapter by ID
  Future<void> getChapterById({
    required String courseSlug,
    required int chapterId,
  }) async {
    emit(
      state.copyWith(
        chaptersStatus: ResponseStatusEnum.loading,
        chaptersError: null,
      ),
    );

    final result = await repo.getChapterByIdRepo(
      courseSlug: courseSlug,
      chapterId: chapterId,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          chaptersStatus: ResponseStatusEnum.failure,
          chaptersError: failure.message,
        ),
      ),
      (chapter) => emit(
        state.copyWith(
          chaptersStatus: ResponseStatusEnum.success,
          chapter: chapter,
        ),
      ),
    );
  }

  //?--------------------------------------------------------
  //* Get Chapter Attachments
  Future<void> getChapterAttachments({required int chapterId}) async {
    emit(
      state.copyWith(
        attachmentsStatus: ResponseStatusEnum.loading,
        attachmentsError: null,
      ),
    );

    final result = await repo.getChapterAttachmentsRepo(chapterId: chapterId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          attachmentsStatus: ResponseStatusEnum.failure,
          attachmentsError: failure.message,
        ),
      ),
      (attachments) => emit(
        state.copyWith(
          attachmentsStatus: ResponseStatusEnum.success,
          attachments: attachments,
        ),
      ),
    );
  }

  //?---- Quiz ----------------------------------------------------

  //* Step 1 : Get Quiz Details by Chapter ID
  Future<void> getQuizDetails({required int chapterId}) async {
    emit(
      state.copyWith(
        quizDetailsStatus: ResponseStatusEnum.loading,
        quizDetailsError: null,
      ),
    );

    final result = await repo.getQuizDetailsByChapterRepo(chapterId: chapterId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          quizDetailsStatus: ResponseStatusEnum.failure,
          quizDetailsError: failure.message,
        ),
      ),
      (quiz) => emit(
        state.copyWith(
          quizDetailsStatus: ResponseStatusEnum.success,
          quizDetails: quiz,
        ),
      ),
    );
  }

  //?--------------------------

  //* Step 2 : Start Quiz
  Future<void> startQuiz({required int quizId}) async {
    emit(
      state.copyWith(
        statrtQuizStatus: ResponseStatusEnum.loading,
        statrtQuizError: null,
      ),
    );

    final result = await repo.startQuizRepo(quizId: quizId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          statrtQuizStatus: ResponseStatusEnum.failure,
          statrtQuizError: failure.message,
        ),
      ),
      (quiz) => emit(
        state.copyWith(
          statrtQuizStatus: ResponseStatusEnum.success,
          statrtQuiz: quiz,
        ),
      ),
    );
  }

  //?--------------------------

  //* Step 3 : Submit Quiz Answer

  Future<void> submitAnswer({
    required int quizId,
    required int questionId,
    required int selectedChoiceId,
  }) async {
    // Emit loading state for this answer
    emit(
      state.copyWith(
        answerStatus: ResponseStatusEnum.loading,
        answerError: null,
      ),
    );

    final result = await repo.submitQuizAnswerRepo(
      quizId: quizId,
      questionId: questionId,
      selectedChoiceId: selectedChoiceId,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            answerStatus: ResponseStatusEnum.failure,
            answerError: failure.message,
          ),
        );
      },
      (answer) {
        emit(
          state.copyWith(
            answerStatus: ResponseStatusEnum.success,
            answer: answer,
          ),
        );
      },
    );
  }

  //?--------------------------------------------------------

  //?--------------------------------------------------------
}
