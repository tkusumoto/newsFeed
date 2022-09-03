import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_feed/const/strings.dart';

class AboutUsPage extends HookConsumerWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final selected = useState(false);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: Strings.animationStart,
          onPressed: () => selected.value = !selected.value,
          child: const Icon(Icons.play_arrow),
        ),
        body: Center(
          child: AnimatedContainer(
            alignment: selected.value
                ? Alignment.bottomCenter
                : AlignmentDirectional.center,
            duration: const Duration(seconds: 2),
            curve: Curves.bounceOut,
            child: Text(
              Strings.welcomeApp,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // child: Text(Strings.AppName),
        ),
      ),
    );
  }
}
