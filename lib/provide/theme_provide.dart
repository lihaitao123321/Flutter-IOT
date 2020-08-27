import 'package:flutter/material.dart';
import '../config/color.dart';

class ThemeProvide with ChangeNotifier {
  int currentIndex = 0;
  Map currentTheme = {"primaryColor": KColor.primaryColor};
  List<Map> themeSelectList = [
    {"label": '屎黄色', "value": Color.fromRGBO(132, 95, 63, 1.0), "index": 0},
    {"label": '蓝色', "value": Colors.blue, "index": 1},
    {"label": '红色', "value": Colors.red, "index": 2},
  ];

  /// 改变主题
  changeTheme(int index) {
    if (currentIndex == 2) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }
    if (currentIndex == 0) {
      currentTheme = {"primaryColor": KColor.primaryColor};
    } else if (currentIndex == 1) {
      currentTheme = {"primaryColor": Colors.blue};
    } else if (currentIndex == 2) {
      currentTheme = {"primaryColor": Colors.red};
    }
    notifyListeners();
  }
}
