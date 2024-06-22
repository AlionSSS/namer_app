import 'package:flutter/material.dart';


/// 从下到上展示 ListView，并且带颜色递减
class ColorListView extends StatelessWidget {
  final Color color;
  final List<(String, bool)> values;
  final int count;

  const ColorListView({super.key, required this.color, required this.values})
      : count = values.length;

  Color buildColor(int i, int len, Color color) {
    return Color.fromARGB(
      255 * (i + 1) ~/ len,
      color.red,
      color.green,
      color.blue * (i + 1) ~/ len,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      reverse: true,
      children: [
        // 因为设置了 reverse，所以需要倒转来循环
        for (var i = count - 1; i >= 0; i--)
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(values[i].$2 ? Icons.favorite : null,
                    color: buildColor(i, count, color)),
                const SizedBox(width: 4),
                Text(
                  values[i].$1,
                  style: TextStyle(color: buildColor(i, count, color)),
                ),
              ],
            ),
          )
      ],
    );
  }
}
