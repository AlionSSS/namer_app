import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/my_app_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    const tipsStyle = TextStyle(fontWeight: FontWeight.bold);

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet.', style: tipsStyle),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You have ${appState.favorites.length} favorites:',
            style: tipsStyle,
          ),
          const SizedBox(height: 20),
          Expanded(
            // SingleChildScrollView: 当子内容超出当前框的高度时，自动换成可向下滑动的框
            // 必须要能够先确定 SingleChildScrollView 当前所在的框的高度，如果没法确定就会有问题（可以在外面套一层 Expanded 来处理，固定下当前框的高度）
            child: SingleChildScrollView(
              child: _FavoriteWrap(
                favorites: appState.favorites,
                onDeleteBtnClick: (pair) => appState.removeFavorite(pair),
              ),
            ),
          ),
        ],
      ),
    );

    // return ;
  }
}

class _FavoriteWrap extends StatelessWidget {
  final Set<WordPair> favorites;
  final Function(WordPair) onDeleteBtnClick;

  const _FavoriteWrap({required this.favorites, required this.onDeleteBtnClick});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30,
      runSpacing: 10,
      children: [
        for (var pair in favorites)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => onDeleteBtnClick(pair),
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 3),
              // Tooltip 用于当文本显示不全时（因为下面固定了宽度），鼠标移动上去会显示提示
              Tooltip(
                message: pair.asLowerCase,
                // 鼠标悬停在该内容上多少时间后进行提示
                waitDuration: const Duration(milliseconds: 600),
                // 使用 SizedBox 固定好宽度，用于保证 Wrap 组件内部每个元素对齐
                child: SizedBox(
                  width: 70,
                  child: Text(
                    pair.asLowerCase,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}
