import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/enroll/data/models/enrollment_model.dart';
import 'package:e_learning/features/enroll/data/source/remote/enroll_remote_data_source.dart';
import 'package:e_learning/features/enroll/data/source/repo/enroll_repository.dart';

class EnrollRepositoryImpl implements EnrollRepository {
  final EnrollRemoteDataSource remoteDataSource;
  final NetworkInfoService networkInfo;

  EnrollRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<EnrollmentModel>>> getMyCourses() async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.getMyCourses();
    } else {
      return Left(FailureNoConnection());
    }
  }
}
