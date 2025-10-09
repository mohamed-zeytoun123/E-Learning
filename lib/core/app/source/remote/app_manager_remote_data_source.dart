import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';

abstract class AppManagerRemoteDataSource {
  //?----------------------------------------------------------------------

  //* LogOut
  Future<Either<Failure, bool>> logout();

  //?----------------------------------------------------------------------
}
