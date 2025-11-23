import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/features/Course/data/models/advertisement_response_model.dart';

abstract class AdvertisementRepository {
  //?-------------------------------------------------

  //* Get Advertisements
  Future<Either<Failure, AdvertisementResponseModel>>
      getAdvertisementsRepo();

  //?-------------------------------------------------
}

