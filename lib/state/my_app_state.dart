
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/// 跨组件的 State 可以结合 provider 库使用 ChangeNotifier
/// 属于单个组件内的 State 用 StatefulWidget
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  List<(String, bool)> histories = [];

  /// 生成下一個 WordPair
  void getNext() {
    histories.add((current.asLowerCase, favorites.contains(current)));
    if (histories.length > 6) {
      histories.removeAt(0);
    }
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>{};

  /// 切换喜欢的状态
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  /// 从最喜欢的列表中移除
  void removeFavorite(WordPair favorite) {
    if (favorites.contains(favorite)) {
      favorites.remove(favorite);
    }
    notifyListeners();
  }


}