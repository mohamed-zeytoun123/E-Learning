import 'package:dartz/dartz.dart';
import 'package:network/failures/failures.dart';
import 'package:e_learning/features/Article/data/models/article_model.dart';
import 'package:e_learning/features/Article/data/models/article_response_model.dart';

abstract class ArticleRemoteDataSource {
  Future<Either<Failure, ArticleResponseModel>> getArticlesRemote({
    int? page,
    int? pageSize,
    String? search,
    int? categoryId,
  });

  Future<Either<Failure, ArticleModel>> getArticleDetailsRemote({
    required int articleId,
  });

  Future<Either<Failure, ArticleResponseModel>> getRelatedArticlesRemote({
    required int articleId,
  });

}
