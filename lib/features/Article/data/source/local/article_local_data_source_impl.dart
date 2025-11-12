import 'package:e_learning/features/Article/data/models/article_model/article_model.dart';
import 'package:e_learning/features/Article/data/source/local/article_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _cacheKey = 'cached_articles';

  ArticleLocalDataSourceImpl({required this.sharedPreferences});

  //?--- Articles -------------------------------------------------

  //* Get Articles From Cache
  @override
  List<ArticleModel> getArticlesInCache() {
    try {
      final cachedData = sharedPreferences.getString(_cacheKey);
      if (cachedData != null) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList
            .map((json) => ArticleModel.fromMap(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  //* Save Articles To Cache
  @override
  Future<void> saveArticlesInCache(List<ArticleModel> articles) async {
    try {
      final jsonList = articles.map((article) => article.toMap()).toList();
      await sharedPreferences.setString(_cacheKey, json.encode(jsonList));
    } catch (_) {}
  }

  //?----------------------------------------------------
}




