import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';
import 'package:news_feed/ui/screens/pages/about_us_page.dart';
import 'package:news_feed/ui/screens/pages/head_line_page.dart';
import 'package:news_feed/ui/screens/pages/news_list_page.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    final pages = [
      const HeadLinePage(),
      const NewsListPage(),
      const AboutUsPage(),
    ];

    return SafeArea(
      child: Scaffold(
        body: pages[currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.highlight),
              label: Strings.headLine,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: Strings.newsList,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: Strings.aboutApp,
            ),
          ],
          onTap: (index) => currentIndex.value = index,
        ),
      ),
    );
  }
}
