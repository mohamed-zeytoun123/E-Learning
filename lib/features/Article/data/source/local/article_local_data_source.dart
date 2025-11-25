import 'package:e_learning/features/Article/data/models/article_model.dart';

abstract class ArticleLocalDataSource {
  //?----------------------------------------------------

  //* Get Articles From Cache
  List<ArticleModel> getArticlesInCache();

  //* Save Articles To Cache
  Future<void> saveArticlesInCache(List<ArticleModel> articles);

  //?----------------------------------------------------
}




