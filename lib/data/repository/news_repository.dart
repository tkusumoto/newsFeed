import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/search_type.dart';

abstract class NewsRepository {
  Future<List<Article>> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  });
}
