import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AboutUsPage extends HookWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
