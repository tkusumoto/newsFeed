import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/ui/components/article_tile_desc.dart';
import 'package:news_feed/ui/components/image_from_url.dart';

class ArticleTile extends ConsumerWidget {
  final Article article;

  final ValueChanged onArticleClicked;

  const ArticleTile({
    Key? key,
    required this.article,
    required this.onArticleClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => onArticleClicked(article),
          child: Column(
            children: [
              ImageFromUrl(imageUrl: article.urlToImage),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ArticleTileDesc(article: article),
              )
            ],
          ),
        ),
      ),
    );
  }
}
