import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/repository/news_repository.dart';
import 'package:news_feed/data/search_type.dart';

class NewsListViewModel extends StateNotifier<AsyncValue<List<Article>>> {
  NewsListViewModel({required this.repository}) : super(const AsyncData([]));

  final NewsRepository repository;

  SearchType _searchType = SearchType.CATEGORY;
  SearchType get searchType => _searchType;

  Category _category = categories[0];
  Category get category => _category;

  String _keyword = "";
  String get keyword => _keyword;

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

    state = const AsyncLoading();

    try {
      final newsList = await repository.getNews(
        searchType: _searchType,
        keyword: _keyword,
        category: _category,
      );
      state = AsyncData(newsList);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}
