import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/Article/data/models/article_model/article_model.dart';
import 'package:e_learning/features/Article/data/models/article_response_model.dart';
import 'package:e_learning/features/Article/data/source/remote/article_remote_data_source.dart';

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final API api;

  ArticleRemoteDataSourceImpl({required this.api});

  //?----------------------------------------------------
  //* Get Articles

  @override
  Future<Either<Failure, ArticleResponseModel>> getArticlesRemote({
    int? page,
    int? pageSize,
    String? search,
    int? categoryId,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'page_size': pageSize.toString(),
        if (search != null && search.isNotEmpty) 'search': search,
        if (categoryId != null) 'category': categoryId.toString(),
      };

      final ApiRequest request = ApiRequest(
        url: AppUrls.getArticles,
        queryParameters: queryParameters,
      );

      log('🌐 Request URL: ${AppUrls.getArticles}');
      log('🌐 Query Parameters: $queryParameters');

      final ApiResponse response = await api.get(request);

      log('📡 Articles API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final articleResponse = ArticleResponseModel.fromMap(data);
          log('✅ Successfully parsed ${articleResponse.results.length} articles');
          return Right(articleResponse);
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
  //* Get Article Details by ID

  @override
  Future<Either<Failure, ArticleModel>> getArticleDetailsRemote({
    required int articleId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.articleDetails(articleId.toString()),
      );

      log('🌐 Request URL: ${AppUrls.articleDetails(articleId.toString())}');

      final ApiResponse response = await api.get(request);

      log('📡 Article Details API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final articleDetails = ArticleModel.fromMap(data);
          log('✅ Successfully parsed article details: ${articleDetails.title}');
          return Right(articleDetails);
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
  //* Get Related Articles by Article ID

  @override
  Future<Either<Failure, ArticleResponseModel>> getRelatedArticlesRemote({
    required int articleId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.relatedArticles(articleId),
      );

      log('🌐 Request URL: ${AppUrls.relatedArticles(articleId)}');

      final ApiResponse response = await api.get(request);

      log('📡 Related Articles API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic>) {
          final relatedArticlesResponse = ArticleResponseModel.fromMap(data);
          log('✅ Successfully parsed ${relatedArticlesResponse.results.length} related articles');
          return Right(relatedArticlesResponse);
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
