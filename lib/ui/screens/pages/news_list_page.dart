import 'package:flutter/material.dart';
import 'package:news_feed/const/strings.dart' as strings;
import 'package:news_feed/data/category_info.dart';
import 'package:news_feed/ui/components/category_chips.dart';
import 'package:news_feed/ui/components/search_bar.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: strings.refresh,
          onPressed: () => onRefresh(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //TODO 検索ワード
              SearchBar(
                  onSearch: (keyword) => getKeywordNews(context, keyword)),
              //TODO カテゴリー選択Chips
              CategoryChips(
                onCategorySelected: (category) =>
                    getCategoryNews(context, category),
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

  //TODO 記事更新処理
  onRefresh(BuildContext context) {}

  //TODO キーワード記事取得処理
  getKeywordNews(BuildContext context, keyword) {
    print("newsListPage.getKeywordNews");
  }

  //TODO カテゴリー記事取得処理
  getCategoryNews(BuildContext context, Category category) {
    print("newsListPage.getCategoryNews: ${category.nameJp}");
  }
}
