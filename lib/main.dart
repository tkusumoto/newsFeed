import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart' as strings;

import 'style/style.dart' as styles;
import 'ui/screens/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: strings.AppName,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: styles.BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
