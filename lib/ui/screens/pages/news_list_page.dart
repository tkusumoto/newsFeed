import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/main.dart';
import 'package:news_feed/ui/components/article_tile.dart';
import 'package:news_feed/ui/components/category_chips.dart';
import 'package:news_feed/ui/components/search_bar.dart';
import 'package:news_feed/ui/screens/web_page_screen.dart';

class NewsListPage extends ConsumerWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(viewModelProvider.notifier);
    viewModel.setParameters(
      searchType: SearchType.CATEGORY,
      category: categories[0],
    );

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
                child: asyncValue.when(
                  data: (articles) => articles.isNotEmpty
                      ? ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, position) => ArticleTile(
                            article: articles[position],
                            onArticleClicked: (article) =>
                                _openArticleWebPage(article, context),
                          ),
                        )
                      : const Center(child: Text(Strings.DataEmpty)),
                  error: (error, _) => Center(child: Text(error.toString())),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
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
    final viewModel = ref.read(viewModelProvider.notifier);

    viewModel.setParameters(
      searchType: viewModel.searchType,
      keyword: viewModel.keyword,
      category: viewModel.category,
    );

    ref.read(counterProvider.notifier).update((state) => state + 1);
  }

  // キーワード記事取得処理
  Future<void> getKeywordNews(
      BuildContext context, keyword, WidgetRef ref) async {
    final viewModel = ref.read(viewModelProvider.notifier);

    viewModel.setParameters(
      searchType: SearchType.KEYWORD,
      keyword: keyword,
      category: categories[0],
    );

    ref.read(counterProvider.notifier).update((state) => state + 1);
  }

  // カテゴリー記事取得処理
  Future<void> getCategoryNews(
      BuildContext context, Category category, WidgetRef ref) async {
    final viewModel = ref.read(viewModelProvider.notifier);

    viewModel.setParameters(
      searchType: SearchType.CATEGORY,
      category: category,
    );

    ref.read(counterProvider.notifier).update((state) => state + 1);
  }

  _openArticleWebPage(Article article, BuildContext context) {
    print("_openArticleWebPage: ${article.url}");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebPageScreen(article: article),
      ),
    );
  }
}
