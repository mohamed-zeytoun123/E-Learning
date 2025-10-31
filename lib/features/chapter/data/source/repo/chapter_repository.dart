import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';

abstract class ChapterRepository {
  //?--------------------------------------------------------

  //* Get Chapter by ID
  Future<Either<Failure, ChapterModel>> getChapterByIdRepo({
    required String courseSlug,
    required int chapterId,
  });

  //?--------------------------------------------------------
}
