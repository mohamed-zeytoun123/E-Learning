import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Banner/data/models/banner_response_model.dart';
import 'package:e_learning/features/Banner/data/source/local/banner_local_data_source.dart';
import 'package:e_learning/features/Banner/data/source/remote/banner_remote_data_source.dart';
import 'package:e_learning/features/Banner/data/source/repo/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource remote;
  final BannerLocalDataSource local;
  final NetworkInfoService network;

  BannerRepositoryImpl({
    required this.remote,
    required this.local,
    required this.network,
  });

  @override
  Future<Either<Failure, BannerResponseModel>> getBannersRepo({
    int? page,
    int? pageSize,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getBannersRemote(
        page: page,
        pageSize: pageSize,
      );

      return result.fold(
        (failure) => Left(failure),
        (bannerResponse) {
          // Save to cache
          if (bannerResponse.results.isNotEmpty) {
            local.saveBannersInCache(bannerResponse.results);
          }
          return Right(bannerResponse);
        },
      );
    } else {
      // Return cached data if available
      final cachedBanners = local.getBannersInCache();
      if (cachedBanners.isNotEmpty) {
        return Right(
          BannerResponseModel(
            count: cachedBanners.length,
            totalPages: 1,
            currentPage: 1,
            pageSize: cachedBanners.length,
            results: cachedBanners,
          ),
        );
      }
      return Left(FailureNoConnection());
    }
  }
}

