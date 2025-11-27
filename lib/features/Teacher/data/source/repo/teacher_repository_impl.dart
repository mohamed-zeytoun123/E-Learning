import 'package:dartz/dartz.dart';
import 'package:network/failures/failures.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_response_model.dart';
import 'package:e_learning/features/Teacher/data/source/local/teacher_local_data_source.dart';
import 'package:e_learning/features/Teacher/data/source/remote/teacher_remote_data_source.dart';
import 'package:e_learning/features/Teacher/data/source/repo/teacher_repository.dart';

class TeacherRepositoryImpl implements TeacherRepository {
  final TeacherRemoteDataSource remote;
  final TeacherLocalDataSource local;
  final NetworkInfoService network;

  TeacherRepositoryImpl({
    required this.remote,
    required this.local,
    required this.network,
  });

  //? -----------------------------------------------------------------
  //* Get Teachers

  @override
  Future<Either<Failure, TeacherResponseModel>> getTeachersRepo({
    int? page,
    int? pageSize,
    String? search,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getTeachersRemote(
        page: page,
        pageSize: pageSize,
        search: search,
      );

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (teacherResponse) async {
          if (teacherResponse.results.isNotEmpty && page == null) {
            // Only cache when fetching first page without pagination
            await local.saveTeachersInCache(teacherResponse.results);
          }
          return Right(teacherResponse);
        },
      );
    } else {
      final cachedTeachers = local.getTeachersInCache();

      if (cachedTeachers.isNotEmpty) {
        // Create a response model from cached data
        final cachedResponse = TeacherResponseModel(
          count: cachedTeachers.length,
          totalPages: 1,
          currentPage: 1,
          pageSize: cachedTeachers.length,
          results: cachedTeachers,
        );
        return Right(cachedResponse);
      } else {
        return Left(Failure(message: 'No internet connection'));
      }
    }
  }

  //?-------------------------------------------------
}

