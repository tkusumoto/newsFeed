import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/repository/news_repository.dart';
import 'package:news_feed/data/search_type.dart';

final newsRepositoryProvider = Provider((ref) => NewsRepositoryImpl(ref.read));

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this._reader);

  final Reader _reader;

  @override
  Future<void> getNews({
    required SearchType searchType,
    String? keyword,
    Category? category,
  }) async {
    print(
        "[Repository] searchType: $searchType / keyword: $keyword / category: ${category?.nameJp}");

    // TODO: implement getNews
    throw UnimplementedError();
  }
}
