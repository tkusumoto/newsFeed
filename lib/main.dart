import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/repository/news_repository_impl.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/view_model/news_list_view_model.dart';

import 'style/style.dart' as styles;
import 'ui/screens/home_screen.dart';

final repositoryProvider = Provider((ref) => NewsRepositoryImpl());

// ViewModel pattern
final viewModelProvider =
    StateNotifierProvider<NewsListViewModel, AsyncValue<List<Article>>>((ref) {
  return NewsListViewModel(repository: ref.read(repositoryProvider));
});

// FutureProvider patten
final newsListProvider = FutureProvider<List<Article>>((ref) async {
  final repository = ref.read(newsRepositoryProvider);
  return repository.getNews(
    searchType: SearchType.CATEGORY,
    category: categories[0],
  );
});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.AppName,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: styles.BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
