import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_feed/const/strings.dart' as strings;
import 'package:news_feed/ui/screens/pages/about_us_page.dart';
import 'package:news_feed/ui/screens/pages/head_line_page.dart';
import 'package:news_feed/ui/screens/pages/news_list_page.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              label: strings.HeadLine,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: strings.NewsList,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: strings.AboutApp,
            ),
          ],
          onTap: (index) => currentIndex.value = index,
        ),
      ),
    );
  }
}
