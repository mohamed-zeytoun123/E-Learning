import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:netwoek/network.dart';
import 'package:netwoek/network/api/api_request.dart';
import 'package:netwoek/network/api/api_response.dart';
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
        headers: ApiRequestParameters.authHeaders,
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final advertisementResponse =
              AdvertisementResponseModel.fromMap(data);
          return Right(advertisementResponse);
        } else {
          return Left(
            Failure(
              message: 'Unexpected response format',
              errorCode: response.statusCode,
            ),
          );
        }
      } else {
        final body = response.body;
        final errorMessage =
            (body is Map<String, dynamic> && body['message'] != null)
                ? body['message'].toString()
                : 'Unknown error';
        return Left(
          Failure(
            message: errorMessage,
            errorCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      if (exception is DioException) {
        return Left(Failure.fromException(exception));
      }
      return Left(Failure(message: exception.toString()));
    }
  }

  //?----------------------------------------------------
}
