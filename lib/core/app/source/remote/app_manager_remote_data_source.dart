import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';

abstract class AppManagerRemoteDataSource {
  //?----------------------------------------------------------------------

  //* LogOut
  Future<Either<Failure, bool>> logout();

  //?----------------------------------------------------------------------
}
