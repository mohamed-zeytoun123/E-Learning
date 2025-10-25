import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewsArticlesPage extends StatelessWidget {
  const NewsArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('news_and_articles'.tr()),
      ),
    );
  }
}
