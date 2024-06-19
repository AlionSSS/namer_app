import 'package:flutter/material.dart';
import 'package:namer_app/component/color_list_view.dart';
import 'package:provider/provider.dart';

import '../component/big_card.dart';
import '../state/my_app_state.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    // 由状态衍生而来的视图变换，可以写在 build 内
    IconData icon = appState.favorites.contains(pair)
        ? Icons.favorite
        : Icons.favorite_border;

    var primaryColor = Theme.of(context).colorScheme.primary;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 210,
            child: ColorListView(
              color: primaryColor,
              values: appState.histories,
            ),
          ),
          const SizedBox(height: 20),
          BigCard(pair: pair),
          const SizedBox(height: 10),

          // Wrap 是一个类似于 Row 或 Column 的 widget，当没有足够的垂直或水平空间时，它会自动将子项封装到下一“行”中
          // direction: Axis.vertical 对应 Column
          // direction: Axis.horizontal 对应 Row，默认
          Wrap(
            // 子组件换行后，居中对齐
            alignment: WrapAlignment.center,
            // 子组件间的间隔。spacing 是默认的左右间隔，runSpacing 换行后的上下间隔
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.toggleFavorite(),
                icon: Icon(icon),
                label: const Text("Like"),
              ),
              ElevatedButton(
                onPressed: () => appState.getNext(),
                child: const Text("Next"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
