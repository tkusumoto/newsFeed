import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/ui/components/category_chips.dart';
import 'package:news_feed/ui/components/search_bar.dart';
import 'package:news_feed/view_model/news_list_view_model.dart';

class NewsListPage extends ConsumerWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              //TODO 検索ワード
              SearchBar(
                  onSearch: (keyword) => getKeywordNews(context, keyword, ref)),
              //TODO カテゴリー選択Chips
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category, ref),
              ),
              //TODO 記事表示

              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
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
    final viewModel = ref.read(newsViewModelProvider);
    await viewModel.fetchNews(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );
  }

  // キーワード記事取得処理
  Future<void> getKeywordNews(
      BuildContext context, keyword, WidgetRef ref) async {
    print("newsListPage.getKeywordNews");
    final viewModel = ref.read(newsViewModelProvider);
    await viewModel.fetchNews(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );
  }

  // カテゴリー記事取得処理
  Future<void> getCategoryNews(
      BuildContext context, Category category, WidgetRef ref) async {
    print("newsListPage.getCategoryNews: ${category.nameJp}");
    final viewModel = ref.read(newsViewModelProvider);
    await viewModel.fetchNews(
      searchType: SearchType.CATEGORY,
      category: category,
    );
  }
}
