import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Article/data/models/article_model.dart';
import 'package:e_learning/features/Article/data/models/article_response_model.dart';
import 'package:e_learning/features/Article/data/source/local/article_local_data_source.dart';
import 'package:e_learning/features/Article/data/source/remote/article_remote_data_source.dart';
import 'package:e_learning/features/Article/data/source/repo/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remote;
  final ArticleLocalDataSource local;
  final NetworkInfoService network;

  ArticleRepositoryImpl({
    required this.remote,
    required this.local,
    required this.network,
  });

  //? -----------------------------------------------------------------
  //* Get Articles

  @override
  Future<Either<Failure, ArticleResponseModel>> getArticlesRepo({
    int? page,
    int? pageSize,
    String? search,
    int? categoryId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getArticlesRemote(
        page: page,
        pageSize: pageSize,
        search: search,
        categoryId: categoryId,
      );

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (articleResponse) async {
          if (articleResponse.results.isNotEmpty && page == null) {
            // Only cache when fetching first page without pagination
            await local.saveArticlesInCache(articleResponse.results);
          }
          return Right(articleResponse);
        },
      );
    } else {
      final cachedArticles = local.getArticlesInCache();

      if (cachedArticles.isNotEmpty) {
        // Create a response model from cached data
        final cachedResponse = ArticleResponseModel(
          count: cachedArticles.length,
          totalPages: 1,
          currentPage: 1,
          pageSize: cachedArticles.length,
          results: cachedArticles,
        );
        return Right(cachedResponse);
      } else {
        return Left(Failure(message: 'No internet connection'));
      }
    }
  }

  //? -----------------------------------------------------------------
  //* Get Article Details by ID

  @override
  Future<Either<Failure, ArticleModel>> getArticleDetailsRepo({
    required int articleId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getArticleDetailsRemote(
        articleId: articleId,
      );

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (articleDetails) {
          return Right(articleDetails);
        },
      );
    } else {
      return Left(Failure(message: 'No internet connection'));
    }
  }

  //? -----------------------------------------------------------------
  //* Get Related Articles by Article ID

  @override
  Future<Either<Failure, ArticleResponseModel>> getRelatedArticlesRepo({
    required int articleId,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getRelatedArticlesRemote(
        articleId: articleId,
      );

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (relatedArticlesResponse) {
          return Right(relatedArticlesResponse);
        },
      );
    } else {
      return Left(Failure(message: 'No internet connection'));
    }
  }

  //?-------------------------------------------------
}
