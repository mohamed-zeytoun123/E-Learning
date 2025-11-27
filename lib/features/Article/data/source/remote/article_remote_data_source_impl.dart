import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/api/api_parameters.dart';
import 'package:e_learning/core/api/api_urls.dart';
import 'package:network/failures/failures.dart';
import 'package:network/network.dart';
import 'package:network/network/api/api_request.dart';
import 'package:e_learning/features/Article/data/models/article_model.dart';
import 'package:e_learning/features/Article/data/models/article_response_model.dart';
import 'package:e_learning/features/Article/data/source/remote/article_remote_data_source.dart';

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final API api;

  ArticleRemoteDataSourceImpl({
    required this.api,
  });
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

      final request = ApiRequest(
        url: AppUrls.getArticles,
        params: queryParameters,
        headers: ApiRequestParameters.authHeaders,
      );

      final response = await api.get(request);

      if (response.success && response.body != null) {
        // The API returns the ArticleResponseModel directly in the body, not wrapped in 'data'
        final articleResponse = ArticleResponseModel.fromMap(
          Map<String, dynamic>.from(response.body!),
        );
        return Right(articleResponse);
      } else {
        final errorMessage = response.body?['message']?.toString() ??
            response.body?['error']?.toString() ??
            'Failed to load articles';
        return Left(Failure(message: errorMessage));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: 'Unknown Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ArticleModel>> getArticleDetailsRemote({
    required int articleId,
  }) async {
    try {
      final request = ApiRequest(
        url: AppUrls.articleDetails(articleId.toString()),
        headers: ApiRequestParameters.authHeaders,
      );

      final response = await api.get(request);

      if (response.success && response.body != null) {
        // Check if data is wrapped in 'data' key or directly in body
        final bodyMap = Map<String, dynamic>.from(response.body!);
        final data = bodyMap['data'] ?? bodyMap;
        final article = ArticleModel.fromMap(
            data is Map ? Map<String, dynamic>.from(data) : bodyMap);
        return Right(article);
      } else {
        final errorMessage = response.body?['message']?.toString() ??
            response.body?['error']?.toString() ??
            'Failed to load article details';
        return Left(Failure(message: errorMessage));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: 'Unknown Error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ArticleResponseModel>> getRelatedArticlesRemote({
    required int articleId,
  }) async {
    try {
      final request = ApiRequest(
        url: AppUrls.relatedArticles(articleId),
        headers: ApiRequestParameters.authHeaders,
      );

      final response = await api.get(request);

      if (response.success && response.body != null) {
        // The API returns the ArticleResponseModel directly in the body, not wrapped in 'data'
        final articleResponse = ArticleResponseModel.fromMap(
          Map<String, dynamic>.from(response.body!),
        );
        return Right(articleResponse);
      } else {
        final errorMessage = response.body?['message']?.toString() ??
            response.body?['error']?.toString() ??
            'Failed to load related articles';
        return Left(Failure(message: errorMessage));
      }
    } catch (e) {
      if (e is DioException) {
        return Left(Failure.fromException(e));
      }
      return Left(Failure(message: 'Unknown Error: ${e.toString()}'));
    }
  }
}
