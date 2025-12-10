import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/Banner/data/models/banner_response_model.dart';

abstract class BannerRemoteDataSource {
  //?----------------------------------------------------

  //* Get Banners
  Future<Either<Failure, BannerResponseModel>> getBannersRemote({
    int? page,
    int? pageSize,
  });

  //?----------------------------------------------------
}

