import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/source/local/chapter_local_data_source.dart';
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
}
