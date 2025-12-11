import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_response_model.dart';

abstract class TeacherRemoteDataSource {
  //?----------------------------------------------------

  //* Get Teachers
  Future<Either<Failure, TeacherResponseModel>> getTeachersRemote({
    int? page,
    int? pageSize,
    String? search,
  });

  //* Search Teachers (using search endpoint)
  Future<Either<Failure, TeacherResponseModel>> searchTeachersRemote({
    required String query,
    int? limit,
    int? offset,
  });

  //?----------------------------------------------------
}

