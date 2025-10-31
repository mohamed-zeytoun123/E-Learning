import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';

abstract class ChapterRemoteDataSource {
  //?--------------------------------------------------------

  //* Get Chapter by ID
  Future<Either<Failure, ChapterModel>> getChapterByIdRemote({
    required String courseSlug,
    required int chapterId,
  });

  //?--------------------------------------------------------
}
