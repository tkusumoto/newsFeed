import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AboutUsPage extends HookConsumerWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Text("AboutUs"),
          ),
        ),
      ),
    );
  }
}
