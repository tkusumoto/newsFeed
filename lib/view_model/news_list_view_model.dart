import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/repository/news_repository.dart';
import 'package:news_feed/data/search_type.dart';

class NewsListViewModel extends StateNotifier<AsyncValue<List<Article>>> {
  NewsListViewModel({required this.repository}) : super(const AsyncData([]));

  final NewsRepository repository;

  SearchType _searchType = SearchType.category;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = "";
  String get keyword => _keyword;

  setParameters({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) {
    _searchType = searchType;
    _keyword = keyword ?? "";
    _category = category ?? categories[0];
  }
}
