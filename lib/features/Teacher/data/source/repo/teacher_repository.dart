import 'package:dartz/dartz.dart';
import 'package:network/failures/failures.dart';
import 'package:e_learning/features/Teacher/data/models/teacher_response_model.dart';

abstract class TeacherRepository {
  //?-------------------------------------------------

  //* Get Teachers
  Future<Either<Failure, TeacherResponseModel>> getTeachersRepo({
    int? page,
    int? pageSize,
    String? search,
  });

  //?-------------------------------------------------
}

