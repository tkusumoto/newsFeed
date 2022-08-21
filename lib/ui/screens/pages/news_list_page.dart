import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/main.dart';
import 'package:news_feed/ui/components/category_chips.dart';
import 'package:news_feed/ui/components/search_bar.dart';

class NewsListPage extends ConsumerWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(newsListProvider);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: Strings.Refresh,
          onPressed: () => onRefresh(context, ref),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //検索ワード
              SearchBar(
                onSearch: (keyword) => getKeywordNews(context, keyword, ref),
              ),
              //カテゴリー選択Chips
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category, ref),
              ),
              //記事表示
              Expanded(
                child: Center(
                  child: asyncValue.when(
                    data: (list) => list.isNotEmpty
                        ? ListView(
                            children: list
                                .map(
                                  (Article article) =>
                                      Text(article.title.toString()),
                                )
                                .toList(),
                          )
                        : const Text(Strings.DataEmpty),
                    error: (error, _) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 記事更新処理
  Future<void> onRefresh(BuildContext context, WidgetRef ref) async {
    print("newsListPage.onRefresh");
    final viewModelNotifier = ref.read(viewModelProvider.notifier);
    viewModelNotifier.fetchNews(
      searchType: viewModelNotifier.searchType,
      keyword: viewModelNotifier.keyword,
      category: viewModelNotifier.category,
    );
  }

  // キーワード記事取得処理
  Future<void> getKeywordNews(
      BuildContext context, keyword, WidgetRef ref) async {
    print("newsListPage.getKeywordNews");
    final viewModelNotifier = ref.read(viewModelProvider.notifier);
    viewModelNotifier.fetchNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );
  }

  // カテゴリー記事取得処理
  Future<void> getCategoryNews(
      BuildContext context, Category category, WidgetRef ref) async {
    print("newsListPage.getCategoryNews: ${category.nameJp}");
    final viewModelNotifier = ref.read(viewModelProvider.notifier);
    viewModelNotifier.fetchNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
  }
}
