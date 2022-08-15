import 'package:flutter/material.dart';
import 'package:news_feed/data/category_info.dart';

class CategoryChips extends StatefulWidget {
  final ValueChanged onCategorySelected;

  CategoryChips({required this.onCategorySelected});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  var value = 0;

  // ChoiceChip参考：https://api.flutter.dev/flutter/material/ChoiceChip-class.html
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      children: List<Widget>.generate(categories.length, (int index) {
        return ChoiceChip(
          label: Text(categories[index].nameJp),
          selected: value == index,
          onSelected: (bool isSelected) {
            setState(() {
              value = isSelected ? index : 0;
              widget.onCategorySelected(categories[index]);
            });
          },
        );
      }).toList(),
    );
  }
}
