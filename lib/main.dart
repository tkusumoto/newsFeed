import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/repository/news_repository_impl.dart';
import 'package:news_feed/view_model/news_list_view_model.dart';

import 'style/style.dart' as styles;
import 'ui/screens/home_screen.dart';

// Provider pattern
final repositoryProvider = Provider((ref) => NewsRepositoryImpl());

// StateProvider pattern
final counterProvider = StateProvider<int>((ref) => 0);

// ViewModel pattern
final viewModelProvider =
    StateNotifierProvider<NewsListViewModel, AsyncValue<List<Article>>>((ref) {
  return NewsListViewModel(repository: ref.read(repositoryProvider));
});

// FutureProvider patten
final newsListProvider = FutureProvider<List<Article>>((ref) async {
  final counter = ref.watch(counterProvider);
  final repository = ref.read(newsRepositoryProvider);
  final viewModelNotifier = ref.watch(viewModelProvider.notifier);
  return repository.getNews(
      searchType: viewModelNotifier.searchType,
      keyword: viewModelNotifier.keyword,
      category: viewModelNotifier.category);
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
      title: Strings.appName,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: styles.boldFont,
      ),
      home: const HomeScreen(),
    );
  }
}
