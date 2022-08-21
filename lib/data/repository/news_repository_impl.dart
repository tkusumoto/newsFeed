import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:news_feed/const/constants.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/model/news.dart';
import 'package:news_feed/data/repository/news_repository.dart';
import 'package:news_feed/data/search_type.dart';

final newsRepositoryProvider = Provider((ref) => NewsRepositoryImpl(ref.read));

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this._reader);

  final Reader _reader;

  static const SUCCESS = 200;

  @override
  Future<List<Article>> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    List<Article> results = [];

    http.Response? response;

    switch (searchType) {
      case SearchType.HEAD_LINE:
        final url =
            Uri.parse("${Constants.BASE_URL}&apiKey=${Constants.API_KEY}");
        response = await http.get(url);
        break;
      case SearchType.KEYWORD:
        final url = Uri.parse(
            "${Constants.BASE_URL}&q=$keyword&pageSize=30&apiKey=${Constants.API_KEY}");
        response = await http.get(url);
        break;
      case SearchType.CATEGORY:
        final url = Uri.parse(
            "${Constants.BASE_URL}&category=${category?.nameEn}&apiKey=${Constants.API_KEY}");
        response = await http.get(url);
        break;
    }

    if (response.statusCode == SUCCESS) {
      final responseBody = response.body;
      results = News.fromJson(jsonDecode(responseBody)).articles;
    } else {
      // TODO エラーハンドリングの調整

      throw Exception("Failed to load news");
    }
    return results;
  }
}
