import 'package:dartz/dartz.dart';
import 'package:netwoek/failures/failures.dart';
import 'package:e_learning/features/Article/data/models/article_model.dart';
import 'package:e_learning/features/Article/data/models/article_response_model.dart';

abstract class ArticleRepository {
  //?-------------------------------------------------

  //* Get Articles
  Future<Either<Failure, ArticleResponseModel>> getArticlesRepo({
    int? page,
    int? pageSize,
    String? search,
    int? categoryId,
  });

  //* Get Article Details by ID
  Future<Either<Failure, ArticleModel>> getArticleDetailsRepo({
    required int articleId,
  });

  //* Get Related Articles by Article ID
  Future<Either<Failure, ArticleResponseModel>> getRelatedArticlesRepo({
    required int articleId,
  });

  //?-------------------------------------------------
}
