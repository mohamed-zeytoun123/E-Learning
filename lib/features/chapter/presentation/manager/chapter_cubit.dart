import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/chapter/data/source/repo/chapter_repository.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit({required this.repo}) : super(ChapterState());
  final ChapterRepository repo;

  //?--------------------------------------------------------
  void selectAnswer({required int questionIndex, required int choiceIndex}) {
    final updated = Map<int, int>.from(state.selectedOptions);
    updated[questionIndex] = choiceIndex;

    emit(state.copyWith(selectedOptions: updated));
  }

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
    // حفظ نسخة من الخيارات الحالية
    final previousOptions = Map<int, int>.from(state.selectedOptions);

    // تحديث UI مباشرة على أساس questionId
    final questionIndex = state.statrtQuiz?.questions.indexWhere(
      (q) => q.id == questionId,
    );
    if (questionIndex != null && questionIndex >= 0) {
      final updated = Map<int, int>.from(state.selectedOptions);
      updated[questionIndex] = state.selectedOptions[questionIndex] ?? 0;
      emit(state.copyWith(selectedOptions: updated));
    }

    // Emit loading state
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
            selectedOptions: previousOptions,
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
  //* Step 4 : Submit Completed Quiz (Final submit + grading)
  Future<void> submitCompletedQuiz({required int attemptId}) async {
    emit(
      state.copyWith(
        submitStatus: ResponseStatusEnum.loading,
        submitError: null,
      ),
    );

    final result = await repo.submitCompletedQuizRepo(attemptId: attemptId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            submitStatus: ResponseStatusEnum.failure,
            submitError: failure.message,
          ),
        );
      },
      (submit) {
        emit(
          state.copyWith(
            submitStatus: ResponseStatusEnum.success,
            submit: submit,
          ),
        );
      },
    );
  }

  //?--------------------------------------------------------
}
