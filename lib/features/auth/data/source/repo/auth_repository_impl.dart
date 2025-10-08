import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/auth/data/source/local/auth_local_data_source.dart';
import 'package:e_learning/features/auth/data/source/remote/auth_remote_data_source.dart';
import 'package:e_learning/features/auth/data/source/repo/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;
  final NetworkInfoService network;

  AuthRepositoryImpl({
    required this.remote,
    required this.local,
    required this.network,
  });
  //? -----------------------------------------------------------------

  //? -----------------------------------------------------------------
}
