import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_feed/data/category_info.dart';

class CategoryChips extends HookWidget {
  final ValueChanged onCategorySelected;

  CategoryChips({required this.onCategorySelected});

  // ChoiceChip参考：https://api.flutter.dev/flutter/material/ChoiceChip-class.html
  @override
  Widget build(BuildContext context) {
    final indexValue = useState(0);

    return Wrap(
      spacing: 4.0,
      children: List<Widget>.generate(categories.length, (int index) {
        return ChoiceChip(
          label: Text(categories[index].nameJp),
          selected: indexValue.value == index,
          onSelected: (bool isSelected) {
            indexValue.value = isSelected ? index : 0;
            onCategorySelected(categories[index]);
          },
        );
      }).toList(),
    );
  }
}
