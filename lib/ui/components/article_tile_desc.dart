import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:news_feed/style/style.dart';

class ArticleTileDesc extends ConsumerWidget {
  final Article article;
  const ArticleTileDesc({
    required this.article,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title ?? Strings.EmptyString,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 2.0,
        ),
        Text(
          article.publishedAt.toString(),
          style: textTheme.overline?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          article.description ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: textTheme.bodyLarge?.copyWith(
            fontFamily: RegularFont,
          ),
        ),
      ],
    );
  }
}
