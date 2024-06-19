import 'package:flutter/material.dart';

import 'favorites_page.dart';
import 'generator_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  var selectedIndex = 0;

  void _onNaviSelected(value) {
    setState(() => selectedIndex = value);
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const GeneratorPage();
        break;
      case 1:
        page = const FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Namer App"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Row(
            children: [
              // 左侧导航栏
              SafeArea(
                child: NavigationRail(
                  // extended: true 时，将额外显示 label
                  // 结合 LayoutBuilder 实现，它可以自动感知区域大小。区域宽度 >= 600 像素时，就显示 label。
                  extended: constraints.maxWidth >= 600,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text("Home"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text("Favorite"),
                    )
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: _onNaviSelected,
                ),
              ),
              // 右侧页面
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
