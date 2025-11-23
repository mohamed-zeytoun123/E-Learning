import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/Course/data/models/advertisement_response_model.dart';
import 'package:e_learning/features/Course/data/source/remote/advertisement_remote_data_source.dart';

class AdvertisementRemoteDataSourceImpl
    implements AdvertisementRemoteDataSource {
  final API api;

  AdvertisementRemoteDataSourceImpl({required this.api});

  //?----------------------------------------------------
  //* Get Advertisements

  @override
  Future<Either<Failure, AdvertisementResponseModel>>
      getAdvertisementsRemote() async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getAdvertisements,
      );

      log('🌐 Request URL: ${AppUrls.getAdvertisements}');

      final ApiResponse response = await api.get(request);

      log('📡 Advertisements API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final advertisementResponse =
              AdvertisementResponseModel.fromMap(data);
          log(
              '✅ Successfully parsed ${advertisementResponse.results.length} advertisements');
          return Right(advertisementResponse);
        } else {
          return Left(
            Failure(
              message: 'Unexpected response format',
              statusCode: response.statusCode,
            ),
          );
        }
      } else {
        String errorMessage = 'Unknown error';
        if (response.body is Map<String, dynamic>) {
          errorMessage =
              response.body['message']?.toString() ?? 'Unknown error';
        }
        return Left(
          Failure(
            message: errorMessage,
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?----------------------------------------------------
}

