import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/constants.dart';
import 'package:news_feed/const/strings.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/data/search_type.dart';
import 'package:news_feed/main.dart';
import 'package:news_feed/ui/components/article_tile.dart';
import 'package:news_feed/ui/screens/web_page_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HeadLinePage extends ConsumerWidget {
  const HeadLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(viewModelProvider.notifier);
    viewModel.setParameters(
      searchType: SearchType.headLine,
    );

    final asyncValue = ref.watch(newsListProvider);

    PageController pageController = PageController();

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: Strings.refresh,
          onPressed: () => onRefresh(context, ref),
          child: const Icon(Icons.refresh),
        ),
        body: Column(
          children: [
            Expanded(
              child: asyncValue.when(
                data: (articles) => articles.isNotEmpty
                    ? PageView.builder(
                        controller: pageController,
                        itemCount: articles.length,
                        itemBuilder: (context, position) => ArticleTile(
                          article: articles[position],
                          onArticleClicked: (article) =>
                              _openArticleWebPage(article, context),
                        ),
                      )
                    : const Center(child: Text(Strings.dataEmpty)),
                error: (error, _) => Center(child: Text(error.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SmoothPageIndicator(
                  controller: pageController,
                  count: Constants.pageSize,
                  effect: const WormEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    type: WormType.normal,
                  ), // your preferred effect
                  onDotClicked: (index) {}),
            )
          ],
        ),
      ),
    );
  }

  onRefresh(BuildContext context, WidgetRef ref) async {
    final viewModel = ref.read(viewModelProvider.notifier);

    viewModel.setParameters(
      searchType: SearchType.headLine,
    );

    ref.read(counterProvider.notifier).update((state) => state + 1);
  }

  _openArticleWebPage(Article article, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebPageScreen(article: article),
      ),
    );
  }
}
