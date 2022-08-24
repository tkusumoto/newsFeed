import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';
import 'package:news_feed/data/model/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageScreen extends ConsumerWidget {
  final Article article;

  const WebPageScreen({required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(article.title ?? Strings.EmptyString),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: article.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
