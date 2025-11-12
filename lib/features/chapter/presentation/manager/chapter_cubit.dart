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
}
