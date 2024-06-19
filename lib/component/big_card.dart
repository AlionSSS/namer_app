import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  final WordPair pair;

  const BigCard({super.key, required this.pair});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstStyle = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);
    final secondStyle = firstStyle.copyWith(fontWeight: FontWeight.bold);
    var row = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // semanticsLabel: "${pair.first} ${pair.second}"
            Text(pair.first, style: firstStyle),
            Text(pair.second, style: secondStyle),
          ],
        );

    // 自动根据内容大小变换的动画
    return AnimatedSize(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: Card(
          color: theme.colorScheme.primary,
          // elevation 是 Card 的阴影大小
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: row,
          ),
        ),
    );
  }
}
