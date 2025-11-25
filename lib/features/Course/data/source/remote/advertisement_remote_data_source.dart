import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/features/Course/data/models/advertisement_response_model.dart';

abstract class AdvertisementRemoteDataSource {
  //?----------------------------------------------------

  //* Get Advertisements
  Future<Either<Failure, AdvertisementResponseModel>> getAdvertisementsRemote();

  //?----------------------------------------------------
}

