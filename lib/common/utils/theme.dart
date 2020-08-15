import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {
  int _countColor;
  Counter(this._countColor);
  //change themecolor

  void countColors(int index) {
    _countColor = index;
    notifyListeners();
  }

  get countColor => _countColor;
}

List<Color> colorsList = [
  Colors.blue,
  Colors.lightBlue,
  Colors.teal,
  Colors.pink,
  Colors.yellow,
  Colors.orange,
  Colors.red,
  Colors.green,
  Colors.cyan,
  Colors.grey[900],
  Colors.black,
];
List<String> colorsListText = [
  "天空蓝",
  "大海蓝",
  "头顶绿",
  "少女粉",
  "天空蓝",
  "天空蓝",
  "天空蓝",
  "天空蓝",
  "天空蓝",
  "天空蓝",
  "天空蓝",
];
