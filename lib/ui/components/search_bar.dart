import 'package:flutter/material.dart';
import 'package:news_feed/const/strings.dart' as strings;

class SearchBar extends StatelessWidget {
  final ValueChanged onSearch;

  SearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          onSubmitted: onSearch,
          maxLines: 1,
          decoration: const InputDecoration(
              icon: Icon(Icons.search),
              hintText: strings.InputSearchWord,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
