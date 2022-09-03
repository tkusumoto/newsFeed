import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:news_feed/const/constants.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/model/news.dart';
import 'package:news_feed/data/repository/news_repository.dart';
import 'package:news_feed/data/search_type.dart';

final newsRepositoryProvider = Provider((ref) => NewsRepositoryImpl());

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl();

  static const success = 200;

  @override
  Future<List<Article>> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    List<Article> results = [];

    http.Response? response;

    switch (searchType) {
      case SearchType.headLine:
        final url = Uri.parse(
            "${Constants.baseUrl}&pageSize=${Constants.pageSize}&apiKey=${Constants.apiKey}");
        response = await http.get(url);
        break;
      case SearchType.keyword:
        final url = Uri.parse(
            "${Constants.baseUrl}&q=$keyword&pageSize=30&apiKey=${Constants.apiKey}");
        response = await http.get(url);
        break;
      case SearchType.category:
        final url = Uri.parse(
            "${Constants.baseUrl}&category=${category?.nameEn}&apiKey=${Constants.apiKey}");
        response = await http.get(url);
        break;
    }

    if (response.statusCode == success) {
      final responseBody = response.body;
      results = News.fromJson(jsonDecode(responseBody)).articles;
    } else {
      // TODO エラーハンドリングの調整

      throw Exception("Failed to load news");
    }
    return results;
  }
}
