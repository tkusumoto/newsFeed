import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/repository/news_repository.dart';
import 'package:news_feed/data/repository/news_repository_impl.dart';
import 'package:news_feed/data/search_type.dart';

// TODO 後ほどFutureProvider等へ変更予定
final newsViewModelProvider =
    ChangeNotifierProvider((ref) => NewsListViewModel(ref.read));

class NewsListViewModel extends ChangeNotifier {
  NewsListViewModel(this._reader);
  final Reader _reader;

  late final NewsRepository _repository = _reader(newsRepositoryProvider);

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = "";
  String get keyword => _keyword;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Article>? _articles;
  List<Article>? get articles => _articles;

  Future<void> fetchNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    print(
        "[ViewModel] searchType: $searchType / keyword: $keyword / category: ${category?.nameJp}");

    _searchType = searchType;
    _category = category ?? categories[0];
    _keyword = keyword ?? "";

    _isLoading = true;

    await _repository
        .getNews(
          searchType: _searchType,
          keyword: _keyword,
          category: _category,
        )
        .then((value) => _articles = value);

    _isLoading = false;
  }
}
