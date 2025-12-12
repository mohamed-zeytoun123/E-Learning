import 'package:dartz/dartz.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/services/network/network_info_service.dart';
import 'package:e_learning/features/Article/data/models/article_model/article_model.dart';
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
    int? universityId,
    int? collegeId,
    int? studyYear,
  }) async {
    if (await network.isConnected) {
      final result = await remote.getArticlesRemote(
        page: page,
        pageSize: pageSize,
        search: search,
        categoryId: categoryId,
        universityId: universityId,
        collegeId: collegeId,
        studyYear: studyYear,
      );

      return result.fold(
        (failure) {
          print('❌ Repository: Remote call failed - ${failure.message}');
          return Left(failure);
        },
        (articleResponse) async {
          print(
              '📦 Repository: Received ${articleResponse.results.length} articles from remote');
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
        print(
            '📦 Repository: Loaded ${cachedArticles.length} articles from cache');
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
        print('❌ Repository: No cached articles available');
        return Left(FailureNoConnection());
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
          print(
              '❌ Repository: Failed to get article details - ${failure.message}');
          return Left(failure);
        },
        (articleDetails) {
          print(
              '✅ Repository: Successfully fetched article details: ${articleDetails.title}');
          return Right(articleDetails);
        },
      );
    } else {
      print('❌ Repository: No internet connection for article details');
      return Left(FailureNoConnection());
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
          print(
              '❌ Repository: Failed to get related articles - ${failure.message}');
          return Left(failure);
        },
        (relatedArticlesResponse) {
          print(
              '✅ Repository: Successfully fetched ${relatedArticlesResponse.results.length} related articles');
          return Right(relatedArticlesResponse);
        },
      );
    } else {
      print('❌ Repository: No internet connection for related articles');
      return Left(FailureNoConnection());
    }
  }

  //?-------------------------------------------------
}
