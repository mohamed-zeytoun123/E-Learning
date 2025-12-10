import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/Banner/data/models/banner_response_model.dart';
import 'package:e_learning/features/Banner/data/source/remote/banner_remote_data_source.dart';

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final API api;

  BannerRemoteDataSourceImpl({required this.api});

  @override
  Future<Either<Failure, BannerResponseModel>> getBannersRemote({
    int? page,
    int? pageSize,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getBanners,
        queryParameters: queryParameters,
      );

      log('🌐 Request URL: ${AppUrls.getBanners}');
      log('🌐 Query Parameters: $queryParameters');

      final ApiResponse response = await api.get(request);

      log('📡 Banners API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final bannerResponse = BannerResponseModel.fromJson(data);
          log('✅ Successfully parsed ${bannerResponse.results.length} banners');
          return Right(bannerResponse);
        } else {
          return Left(
            Failure(
              message: 'Unexpected response format',
              statusCode: response.statusCode,
            ),
          );
        }
      } else {
        return Left(
          Failure(
            message: 'Failed to load banners',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e) {
      log('❌ BannerRemoteDataSource: Exception - $e');
      return Left(FailureServer(message: e.toString()));
    }
  }
}

