import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Course/data/models/advertisement_response_model.dart';
import 'package:e_learning/features/Course/data/source/local/advertisement_local_data_source.dart';
import 'package:e_learning/features/Course/data/source/remote/advertisement_remote_data_source.dart';
import 'package:e_learning/features/Course/data/source/repo/advertisement_repository.dart';

class AdvertisementRepositoryImpl implements AdvertisementRepository {
  final AdvertisementRemoteDataSource remote;
  final AdvertisementLocalDataSource local;
  final NetworkInfoService network;

  AdvertisementRepositoryImpl({
    required this.remote,
    required this.local,
    required this.network,
  });

  //? -----------------------------------------------------------------
  //* Get Advertisements

  @override
  Future<Either<Failure, AdvertisementResponseModel>>
      getAdvertisementsRepo() async {
    if (await network.isConnected) {
      final result = await remote.getAdvertisementsRemote();

      return result.fold(
        (failure) {
          print('❌ Repository: Remote call failed - ${failure.message}');
          return Left(failure);
        },
        (advertisementResponse) async {
          print(
              '📦 Repository: Received ${advertisementResponse.results.length} advertisements from remote');
          if (advertisementResponse.results.isNotEmpty) {
            await local.saveAdvertisementsInCache(
                advertisementResponse.results);
          }
          return Right(advertisementResponse);
        },
      );
    } else {
      final cachedAdvertisements = local.getAdvertisementsInCache();

      if (cachedAdvertisements.isNotEmpty) {
        print(
            '📦 Repository: Loaded ${cachedAdvertisements.length} advertisements from cache');
        // Create a response model from cached data
        final cachedResponse = AdvertisementResponseModel(
          count: cachedAdvertisements.length,
          totalPages: 1,
          currentPage: 1,
          pageSize: cachedAdvertisements.length,
          results: cachedAdvertisements,
        );
        return Right(cachedResponse);
      } else {
        print('❌ Repository: No cached advertisements available');
        return Left(FailureNoConnection());
      }
    }
  }

  //?-------------------------------------------------
}

